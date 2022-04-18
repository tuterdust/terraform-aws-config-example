resource "aws_s3_bucket" "demo_config_bucket" {
  bucket = "demo-config-bucket"

  tags = {
    Name = "demo-config-bucket"
  }
}

# Replace awsAccount1|2|3Id with your aws accounts'id
resource "aws_s3_bucket_policy" "aws_config_bucket_policy" {
  bucket = "demo-config-bucket"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSConfigBucketPermissionsCheck",
            "Effect": "Allow",
            "Principal": {
                "Service": "config.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::demo-config-bucket"
        },
        {
            "Sid": "AWSConfigBucketDelivery",
            "Effect": "Allow",
            "Principal": {
                "Service": "config.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "arn:aws:s3:::demo-config-bucket/AWSLogs/{awsAccount1Id}/Config/*",
                "arn:aws:s3:::demo-config-bucket/AWSLogs/{awsAccount2Id}/Config/*",
                "arn:aws:s3:::demo-config-bucket/AWSLogs/{awsAccount3Id}/Config/*"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
