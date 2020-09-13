terraform {
  backend "s3" {
    bucket = "myterraform-state-2022"
    key = "terraform.tfstate-development"
    region = "us-east-1"
    dynamodb_table = "terraformstatelock"
  }
}
