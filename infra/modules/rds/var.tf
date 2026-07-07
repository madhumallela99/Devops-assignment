variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "db_name" {
  default = "hoteldb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  sensitive = true
}

variable "engine" {
  default = "postgres"
}

variable "engine_version" {
  default = "16.3"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 20
}

variable "backup_retention" {
  default = 1
}

variable "deletion_protection" {
  default = false
}