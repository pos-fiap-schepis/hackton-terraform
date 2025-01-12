resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    { Name = "${var.name}-subnet-group" }
  )
}

# RDS Security Group (if not passed from the parent)
resource "aws_security_group" "this" {
  count  = var.create_security_group ? 1 : 0
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allow_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-sg" }
  )
}

# RDS Instance
resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  engine                 = "postgres"
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.create_security_group ? [aws_security_group.this[0].id] : var.security_group_ids

  tags = var.tags
}

output "rds_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.this.endpoint
}