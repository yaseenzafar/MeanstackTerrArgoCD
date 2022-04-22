provider "aws" {
    region = "us-east-1"
    
}

data "aws_availability_zones" "azs" {
    state = "available"
}

terraform {
  backend "s3" {
    bucket = "<replace-with-s3-bucket>"
    key    = "eu-west-1/tfstate.json"
    region = "eu-west-1"
    dynamodb_table = "<replace-with-dynamodb-table>"
    encrypt = true
  }
}