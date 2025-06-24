variable "db_user" {}
variable "db_password" {}
variable "db_subnet_group" {}
variable "security_group_id" {}

resource "aws_db_instance" "recetas_db" {
  identifier              = "recetas-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  username                = var.db_user
  password                = var.db_password
  db_subnet_group_name    = var.db_subnet_group
  vpc_security_group_ids  = [var.security_group_id]
  allocated_storage       = 20
  skip_final_snapshot     = true
}