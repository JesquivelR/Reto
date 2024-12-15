output "alb_dns" {
  description = "DNS del ALB"
  value       = aws_lb.this.dns_name
}

output "app1_target_group_arn" {
  description = "ARN del target group para App1"
  value       = aws_lb_target_group.app1.arn
}

output "app2_target_group_arn" {
  description = "ARN del target group para App2"
  value       = aws_lb_target_group.app2.arn
}