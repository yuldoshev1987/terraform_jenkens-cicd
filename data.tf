data "aws_vpc" "default" {}
data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
data "aws_vpc" "develoment_vpc" {
   filter {
    name = "tag:Name"
    values = ["Development"]
  }
}
/*
data "aws_subnet_ids" "dev_public_subnets" {
  vpc_id = data.aws_vpc.develoment_vpc.id

  */
/*filter {
    name   = "tag:Name"
    values = ["PublicSubnet"]
  }*//*

}*/