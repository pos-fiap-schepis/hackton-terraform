output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public.*.id
}

output "public_subnet_azs" {
  description = "List of AZs for public subnets"
  value       = aws_subnet.public.*.availability_zone
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}
