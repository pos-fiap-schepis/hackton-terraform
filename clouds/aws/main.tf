# ROLE to create resources
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# VPC Module
module "vpc" {
  source               = "./modules/vpc"
  name                 = "multi-cluster-vpc"
  cidr                 = "10.0.0.0/16"
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
  name                  = "hackaton-database"
  db_name               = "hackaton"
  username              = "postgres"
  password              = "postgres"
  immediately           = true
  subnet_ids            = module.vpc.public_subnets
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

module "s3_backend" {
  source              = "./modules/s3"
  bucket_name         = "pos-fiap-schepis"
}