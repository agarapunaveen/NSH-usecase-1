output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet" {
  value = aws_subnet.public
}
output "private_subnet" {
  value = aws_subnet.private
}