import boto3

print('Loading function')

s3 = boto3.client('s3')


def lambda_handler(event, context):
  
    bucket = 'githubbkp'
    response = s3.get_object(Bucket=bucket)
    print(response)