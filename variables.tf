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