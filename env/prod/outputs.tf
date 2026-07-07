output "alb_dns_name" {

  value = module.ecs.alb_dns_name

}
output "ecs_cluster" {

  value = module.ecs.ecs_cluster_name

}
output "database_endpoint" {

  value = module.rds.db_endpoint

}
output "database_name" {

  value = module.rds.db_name

}