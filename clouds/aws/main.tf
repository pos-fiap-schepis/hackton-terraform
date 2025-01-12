# ROLE to create resources
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# VPC Module
module "vpc" {
  source               = "./modules/vpc"
  name                 = "multi-cluster-vpc"
  cidr                 = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  availability_zone    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  tags                 = { Project = "multi-cluster" }
}

# EKS Cluster for Applications
module "app_cluster" {
  source           = "./modules/eks"
  name             = "app-cluster"
  cluster_role_arn = data.aws_iam_role.lab_role.arn
  node_role_arn    = data.aws_iam_role.lab_role.arn
  private_subnets  = module.vpc.private_subnets
  desired_capacity = 2
  max_capacity     = 3
  min_capacity     = 1
  instance_types   = ["t3.large"]
  tags             = { Environment = "app", Project = "multi-cluster" }
}

# EKS Cluster for Infrastructure
module "infra_cluster" {
  source           = "./modules/eks"
  name             = "infra-cluster"
  cluster_role_arn = data.aws_iam_role.lab_role.arn
  node_role_arn    = data.aws_iam_role.lab_role.arn
  private_subnets  = module.vpc.private_subnets
  instance_types   = ["t3.large"]
  desired_capacity = 2
  max_capacity     = 3
  min_capacity     = 1
  tags             = { Environment = "infra", Project = "multi-cluster" }
}

# RDS to application and keycloack
module "rds" {
  source                = "./modules/rds"
  name                  = "app-database"
  db_name               = "appdb"
  username              = "postgres"
  password              = "postgres"
  immediately           = true
  subnet_ids            = module.vpc.private_subnets
  security_group_ids    = []
  create_security_group = true
  vpc_id                = module.vpc.vpc_id
  allocated_storage     = 20
  engine_version        = "16.4"
  instance_class        = "db.t3.micro"
  allow_cidr_blocks     = ["10.0.3.0/24", "10.0.4.0/24"]
  tags                  = { Environment = "app", Project = "multi-cluster" }
}

# ECR to push docker images
module "app_ecr" {
  source = "./modules/ecr"
  tags   = { Environment = "app", Project = "multi-cluster" }
}
