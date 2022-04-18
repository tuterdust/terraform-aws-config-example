provider "aws" {
  alias   = "account_1"
  region  = var.aws_region
  profile = var.aws_account_1_profile
}

provider "aws" {
  alias   = "account_2"
  region  = var.aws_region
  profile = var.aws_account_2_profile
}

provider "aws" {
  alias   = "account_3"
  region  = var.aws_region
  profile = var.aws_account_3_profile
}

module "account_1" {
  providers = {
    aws = aws.account_1
  }
  source = "./account-1"
}

module "account_2" {
  providers = {
    aws = aws.account_2
  }
  source = "./account-2"
}

module "account_3" {
  providers = {
    aws = aws.account_2
  }
  source = "./account-3"
}
