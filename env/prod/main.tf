module "network" {

  source = "../../infra/modules/network"

  project_name = var.project_name

  vpc_cidr = var.vpc_cidr

  public_subnet_1_cidr = var.public_subnet_1_cidr

  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr

  private_subnet_2_cidr = var.private_subnet_2_cidr

  az1 = var.az1

  az2 = var.az2

}
module "ecs" {

  source = "../../infra/modules/ecs"

  project_name = var.project_name

  vpc_id = module.network.vpc_id

  public_subnets = module.network.public_subnets

  private_subnets = module.network.private_subnets

}
module "rds" {

  source = "../../infra/modules/rds"

  project_name = var.project_name

  vpc_id = module.network.vpc_id

  private_subnets = module.network.private_subnets

  ecs_security_group_id = module.ecs.ecs_security_group_id

  db_name = var.db_name

  db_username = var.db_username

  db_password = var.db_password

  instance_class = var.db_instance_class

  backup_retention = var.backup_retention

  deletion_protection = var.deletion_protection

}