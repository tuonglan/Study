require 'aws-sdk'
require 'json'

require_relative 'lib_aws_expansion.rb'

file = File.read('config.txt')
config = JSON.parse file

s3 = Aws::S3::Resource.new(
	credentials: Aws::Credentials.new(config['access_key'], config['private_key']),
	region: 'us-west-1'
	)
#bucket = s3.bucket('adm-tsdump-bucket')
#object = bucket.object('Testing/pics.zip')
#object.upload_file_with_speed('Data/pics.zip', 200000)

uploader = S3Uploader.new(config['access_key'], config['private_key'], 'adm-tsdump-bucket')
uploader.upload_with_speed('data/iphone.mp4', 100000, 'Testing/iphone.mp4')


