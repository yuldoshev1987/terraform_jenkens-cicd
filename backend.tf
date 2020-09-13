terraform {
  backend "s3" {
    bucket = "myterraform-state-2020"
    key = "terraform.tfstate-development"
    region = "us-east-1"
    dynamodb_table = "terraformstatelock"
  }
}