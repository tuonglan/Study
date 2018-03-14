require 'aws-sdk'
require 'json'

file = File.read('config.txt')
config = JSON.parse(file)

s3 = Aws::S3::Resource.new(
	credentials: Aws::Credentials.new(config['access_key'], config['private_key']), 
	region: 'us-west-1'
	)
bucket = s3.bucket('adm-tsdump-bucket')

Dir['data/*'].each do |filename|
	fullpath = File.join(File.expand_path('./'), filename) 
	puts "Uploading file #{fullpath}"
	object = bucket.object("Thumbnails/#{File.basename filename}")
	object.upload_file(fullpath)
end
