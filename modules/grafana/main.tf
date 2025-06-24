variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_id" {}

resource "aws_instance" "grafana" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  security_groups             = [var.security_group_id]

  tags = {
    Name = "GrafanaServer"
  }
}