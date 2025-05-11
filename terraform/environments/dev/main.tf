terraform {
  backend "s3" {
    bucket       = "myapp-terraform-state-671602693322"
    key          = "dev/terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source               = "../../modules/networking"
  name                 = "myapp-dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                  = ["us-west-2a", "us-west-2b"]
}

resource "aws_security_group" "alb" {
  name        = "${var.name}-alb-sg"
  description = "Allow HTTP to ALB"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend" {
  name        = "${var.name}-backend-sg"
  description = "Allow HTTP to backend tasks"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # tighten this in prod!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


module "backend" {
  source            = "../../modules/backend"
  name              = "myapp-dev"
  cpu               = 512
  memory            = 1024
  desired_count     = 2
  image_tag         = var.backend_image_tag # e.g. set in dev.tfvars
  environment       = { ENV = "dev", DB_URL = var.db_url }
  subnet_ids        = module.network.public_subnets
  security_group_id = aws_security_group.backend.id
}

module "frontend" {
  source      = "../../modules/frontend"
  bucket_name = "myapp-dev-static"
  api_dns_name = module.backend.api_url
  name         = var.name 
}
