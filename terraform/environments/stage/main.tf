module "vpc" {
  source             = "../../modules/vpc"
  environment        = var.environment
  cidr               = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "iam" {
  source      = "../../modules/iam"
  environment = var.environment
}

module "alb" {
  source            = "../../modules/alb"
  environment       = var.environment
  app1_image        = var.app1_image
  app2_image        = var.app2_image
  subnets           = module.vpc.public_subnets
  security_group_id = aws_security_group.alb_sg.id
  vpc_id            = module.vpc.vpc_id
}

module "ecs" {
  source                = "../../modules/ecs"
  environment           = var.environment
  aws_region            = var.aws_region
  repositorio_ecr       = var.repositorio_ecr
  app1_image            = var.app1_image
  app2_image            = var.app2_image
  image_tag             = var.image_tag
  subnets               = module.vpc.private_subnets
  security_group_id     = aws_security_group.ecs_sg.id
  app1_target_group_arn = module.alb.app1_target_group_arn
  app2_target_group_arn = module.alb.app2_target_group_arn
  execution_role_arn    = module.iam.ecs_execution_role_arn
  task_role_arn         = module.iam.ecs_task_role_arn
  desired_count         = 2
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg-${var.environment}"
  description = "Security group para ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg-${var.environment}"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg-${var.environment}"
  description = "Security group para ECS tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-sg-${var.environment}"
  }
}

module "updatedeploy" {
  source         = "../../modules/updatedeploy"
  environment    = var.environment
  ecs_cluster    = module.ecs.ecs_cluster_id
  aws_region     = var.aws_region
  repositorio_ecr       = var.repositorio_ecr
  app1_image            = var.app1_image
  app2_image            = var.app2_image
  image_tag             = var.image_tag
  execution_role_arn    = module.iam.ecs_execution_role_arn
  task_role_arn         = module.iam.ecs_task_role_arn
  services_json  = jsonencode({
    "app1" = var.app1_image,
    "app2" = var.app2_image
  })
}
