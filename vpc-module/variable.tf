variable "env" {


}

variable "projectname" {
  
}

output "subnet_id_public" {
  value = [for pubsub in aws_subnet.public_subnet : pubsub.id]
  sensitive = true
}

output "subnet_id_private" {
    sensitive = true
  value = [for privsub in aws_subnet.private_subnet : privsub.id]
}
output "default_routetable" {
    value = aws_default_route_table.default_routetable.id
    sensitive = true
  
}
output "vpc_id" {
    value = aws_vpc.my_vpc.id
    sensitive = true
}

output "default_securitygroup" {
    value = aws_vpc.my_vpc.default_security_group_id
    sensitive = true
  
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  
}

variable "public_sub_cidr" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
  
}
variable "private_sub_cidr" {

    description = "A list of CIDR blocks for the private subnets."
    type        = list(string)
  
}
output "cluster_security_group_id" {
  value = aws_security_group.default_sg.id
  sensitive = true
}
output "node_security_group_id" {
  value = aws_security_group.default_sg.id
  sensitive = true
}