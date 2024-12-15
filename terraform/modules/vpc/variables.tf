variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "cidr" {
  description = "CIDR para la VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDR para subredes privadas"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}
