provider "aws" {
  region = "us-west-2"
}

module "static_file_bucket" {
  source = "./s3"
  name = "theangrydev-static-files"
  acl = "public-read"
}
