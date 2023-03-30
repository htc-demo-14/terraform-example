terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.24"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region     = "eu-west-2"
  access_key = var.credentials.access_key
  secret_key = var.credentials.secret_key
}


module "aws_s3" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "new-test-humanitec-23409832489734"
  acl    = "private"
}


variable "credentials" {
  description = "The credentials for connecting to AWS."
  type = object({
    access_key = string
    secret_key = string
  })
  sensitive = true
}
  
  
output "region" {
  value = module.aws_s3.s3_bucket_region
}

output "bucket" {
  value = module.aws_s3.s3_bucket_bucket_domain_name
}

output "aws_access_key_id" {
  value     = var.credentials.access_key
  sensitive = true
}

output "aws_secret_access_key" {
  value     = var.credentials.secret_key
  sensitive = true
}