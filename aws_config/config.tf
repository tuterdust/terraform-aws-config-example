resource "aws_iam_service_linked_role" "aws_config" {
  aws_service_name = "config.amazonaws.com"
}

resource "aws_config_configuration_recorder" "demo_recorder" {
  name     = "demo-recorder"
  role_arn = aws_iam_service_linked_role.aws_config.arn
}

resource "aws_config_delivery_channel" "demo_delivery_channel" {
  name           = "demo"
  s3_bucket_name = "demo-config-bucket"
  sns_topic_arn  = var.your_sns_topic_arn # optional
  depends_on     = [aws_config_configuration_recorder.demo_recorder]
}

resource "aws_config_configuration_recorder_status" "demo_recorder_status" {
  name       = aws_config_configuration_recorder.demo_recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.demo_delivery_channel]
}

resource "aws_config_config_rule" "vpc_default_security_group_closed" {
  name = "vpc-default-security-group-closed"
  source {
    owner             = "AWS"
    source_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}

resource "aws_config_config_rule" "s3_bucket_public_read_prohibited" {
  name                        = "s3-bucket-public-read-prohibited"
  maximum_execution_frequency = "TwentyFour_Hours"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
}
