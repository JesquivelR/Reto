output "lambda_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.update_deploy_lambda.arn
}

output "event_rule_arn" {
  description = "ARN de la regla de EventBridge"
  value       = aws_cloudwatch_event_rule.ecr_push_rule.arn
}
