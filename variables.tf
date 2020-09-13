variable "region" {
  type = string
  default = "us-east-1"
}
variable "ingress_ports" {
  type = list(number)
  default = [80,8080,443]
}
variable "ssh_publicip" {
  type = string
  default = "173.48.205.16/32"
}
variable "username" {
  type = "list"
  default = ["Rano","ashish"]
}
variable "instance_vm_type" {
  type = string
  default = "t2.micro"
}
variable "ssh_key_name" {
  type = string
  default = "My-generic-Public"
}
variable "subnet_ids" {
  type = string
  default = "subnet-0da1069a55a174c27,subnet-00e83b277ac738b0a"
}