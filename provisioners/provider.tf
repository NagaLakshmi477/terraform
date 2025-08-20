terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "5.98.0"
    }
  }
  backend "s3" {
    bucket = "s3-bucket-state-demo"
    key = "remote-state-provisioners"
    region = "us-east-1"
    use_lockfile =  true
    encrypt =  true
    # dynamodb_table = "s3-bucket-state-demo"
  }
}

provider "aws" {
    region = "us-east-1"
  
}