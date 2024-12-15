output "ecs_cluster_id" {
  description = "ID del clúster ECS"
  value       = aws_ecs_cluster.this.id
}

output "app1_service_id" {
  description = "ID del servicio ECS para App1"
  value       = aws_ecs_service.app1.id
}

output "app2_service_id" {
  description = "ID del servicio ECS para App2"
  value       = aws_ecs_service.app2.id
}