module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5.1"


  name = var.vpc-name
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", ]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # enable_nat_gateway = true
  # enable_vpn_gateway = true


  create_database_subnet_group = true
  database_subnets             = ["10.0.151.0/24", "10.0.152.0/24"]

  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  database_subnet_group_name = "free-the-beans-database-subnet-group"
  database_subnet_group_tags = {
    Name = "Free the Beans Database Subnet Group"
  }

}

resource "aws_security_group" "free_the_beans_rds_sg" {
  name_prefix = "free-the-beans-rds-"

  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = local.db_port
    to_port     = local.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
