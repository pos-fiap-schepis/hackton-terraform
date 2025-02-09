resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.name}-vpc"
  })
}

resource "aws_subnet" "public" {
  count = 3
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"], count.index)
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name}-public-${count.index}"
  })
}

resource "aws_subnet" "private" {
  count = 3

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], count.index)
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)

  tags = merge(var.tags, {
    Name = "${var.name}-private-${count.index}"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name}-igw"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    Name = "${var.name}-public-rt"
  })
}

resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "eks-nat-gateway"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "eks-private-route-table"
  }
}

resource "aws_route_table_association" "private_association" {
  count     = 3
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
