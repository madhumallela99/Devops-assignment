variable "aws_region" {}

variable "project_name" {}

variable "vpc_cidr" {}

variable "public_subnet_1_cidr" {}

variable "public_subnet_2_cidr" {}

variable "private_subnet_1_cidr" {}

variable "private_subnet_2_cidr" {}

variable "az1" {}

variable "az2" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {
  sensitive = true
}

variable "db_instance_class" {}

variable "backup_retention" {}

variable "deletion_protection" {}