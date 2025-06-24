variable "cidr_block" {}
variable "subnet_cidrs" { type = list(string) }
variable "availability_zones" { type = list(string) }

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "private" {
  count                   = length(var.subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
}

resource "aws_db_subnet_group" "default" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}