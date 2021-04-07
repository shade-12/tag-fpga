import boto3

s3_resource = boto3.resource('s3')

# s3_resource.create_bucket(Bucket="bucket1")

# upload
s3_resource.Object('bucket1', 'img0.png').upload_file(Filename='/home/pi/Desktop/img0.png')

print("inserted img")

# download
s3_resource.Object('bucket1', 'img0.png').download_file(f'/home/pi/Desktop/img0.png')

# delete img
s3_resource.Object('bucket1', 'img0.png').delete()