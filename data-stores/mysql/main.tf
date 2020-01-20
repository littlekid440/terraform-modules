provider "aws" {
  region = "us-east-2"
}
terraform {
  backend "s3" {
    bucket         = "var.db_remote_state_bucket"
    key            = "var.db_remote_state_key"
    region         = "us-east-2"

    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"

  # How should we set the password?
  password            = var.db_password
}
