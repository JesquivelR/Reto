variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "subnets" {
  description = "Subredes para ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del grupo de seguridad para ALB"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "app1_image" {
  description = "Imagen Docker para App1"
  type        = string
}

variable "app2_image" {
  description = "Imagen Docker para App2"
  type        = string
}