output "alb_dns" {
  description = "DNS del ALB"
  value       = module.alb.alb_dns
}

output "ecs_cluster_id" {
  description = "ID del clúster ECS"
  value       = module.ecs.ecs_cluster_id
}
