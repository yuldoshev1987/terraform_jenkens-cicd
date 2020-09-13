
/*
resource "aws_instance" "webserver_import" {
  ami = "ami-02354e95b39ca8dec"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-06d4e2e1f48292b66","sg-0ff782ea56dca056a"]
  key_name = "My-generic-Public"
  subnet_id = "subnet-084ea6b35e0bdb139"
  tags = {
    Name = "webserver"
  }
}
*/
resource "aws_instance" "vm_instance" {
  ami = "ami-02354e95b39ca8dec"
  instance_type = "t2.micro"
}
