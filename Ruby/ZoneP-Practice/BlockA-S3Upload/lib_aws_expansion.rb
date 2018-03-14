require 'aws-sdk'

module SpeedLimit
	PERIODS = 10

	# Speed = bytes per second
	def upload_file_with_speed filename, speed
		puts "Uploading #{filename} at speed: #{speed} bytes per second"
		file_size = File.size(filename)
		uploaded_size = 0
		bunk_size = speed/SpeedLimit::PERIODS
		File.open filename do |stream|
			while (bunk = stream.read(bunk_size))
				start = Time.now
				attemp = 0
				while true
					begin
						self.put(body: bunk)
						break
					rescue => e
						attemp += 1
						if attemp < 10
							next
						end
						throw e
					end
				end

				# Notification
				puts "\r#{uploaded_size}/#{file_size} bytes uploaded at speed: #{speed} bytes per sec"

				# Sleep for some time
				elapse = Time.now - start
				sleep_time = 1.0/SpeedLimit::PERIODS
				if elapse < sleep_time
					sleep(sleep_time - elapse)
				end
			end
		end
		true
	end
end

Aws::S3::Object.class_eval do
	include SpeedLimit
end


class S3Uploader
	BUNK_SIZE = 5*1024*1024
 public
	def initialize access_key, private_key, bucket
		@s3 = Aws::S3::Client.new(
			region: 'us-west-1',
			credentials: Aws::Credentials.new(access_key, private_key)
		)
		@bucket = bucket
	end

	def upload_with_speed file, speed = 500000, key
		input_opts = {bucket: @bucket, key: key}
		mpu_create_response = @s3.create_multipart_upload(input_opts)
		if mpu_create_response == nil
			puts "Cannot init to upload file #{file} to #{@bucket}"
			return false
		end

		puts "Uploading #{file} at speed: #{speed} bytes per second"
		file_size = File.size(file)
		uploaded_size = 0
		current_part = 1
		sleep_time = BUNK_SIZE.to_f/speed
		File.open file do |stream|
			while (bunk = stream.read(BUNK_SIZE))
				start = Time.now
				attemp = 0
				while true
					begin
						part_respone = @s3.upload_part({
							body: bunk, bucket: @bucket,
							key: key, part_number: current_part,
							upload_id: mpu_create_response.upload_id
						})
						current_part += 1
						break
					rescue => e
						attemp += 1
						if attemp < 10
							next
						end
						return false
					end
				end

				# Notification
				uploaded_size += BUNK_SIZE
				puts "\r#{uploaded_size}/#{file_size} bytes uploaded at speed: #{speed} bytes per sec"

				# Sleep for some time
				elapse = Time.now - start
				if elapse < sleep_time
					puts "Sleep for #{sleep_time - elapse} seconds now"
					sleep(sleep_time - elapse)
				end
			end
		end
	
		# Finish the upload
		input_opts = input_opts.merge({upload_id: mpu_create_response.upload_id})
		parts_resp = @s3.list_parts(input_opts)
		input_opts = input_opts.merge({
			multipart_upload: {
				:parts =>
					parts_resp.parts.map do |part|
						{
							part_number: part.part_number,
							etag: part.etag
						}
					end
			}
		})
		mpu_complete_response = @s3.complete_multipart_upload(input_opts)
		if mpu_complete_response == nil
			puts "Cannot init to upload file #{file} to #{@bucket}"
			return false
		end
		true
	end
end

