terraform {
  backend "s3" {
    bucket  = "sky-interview-terraform-state"
    key     = "terraform-config"
    region  = "eu-west-2"
    profile = "sky"
  }
}

provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "sky"
}
