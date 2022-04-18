module "aws_config" {
  source         = "../aws_config"
  s3_bucket_name = "demo-config-bucket"
}

locals {
  depended_on_module = module.aws_config
}
