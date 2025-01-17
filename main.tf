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

  // Generate randome bucket name
  bucket = "${replace(replace(lower("${var.app_name}-${split(".", var.bucket_id)[3]}"), " ", "_"), ".", "_")}"

}

resource "random_string" "s3_bucket_name" {
  length  = 8
  special = false
}

variable "credentials" {
  description = "The credentials for connecting to AWS."
  type = object({
    access_key = string
    secret_key = string
  })
  sensitive = true
}

variable "app_name" {}
variable "bucket_id" {}

output "region" {
  value = module.aws_s3.s3_bucket_region
}

output "bucket" {
  value = module.aws_s3.s3_bucket_bucket_domain_name
}
