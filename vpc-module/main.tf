resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.projectname}-vpc"
    env = var.env

  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  for_each = toset(var.public_sub_cidr)
  cidr_block = each.value
  tags = {
    Name = "${var.projectname}-public-subnet"
    env = var.env
  }

   availability_zone = element(
    data.aws_availability_zones.available.names,
    index(tolist(var.public_sub_cidr), each.value)
  )
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    for_each = toset(var.private_sub_cidr)
    cidr_block = each.value
    tags = {
      Name = "${var.projectname}-private-subnet"
      env = var.env
    }
  }

resource "aws_default_route_table" "default_routetable" {

    tags = {
        Name = "${var.projectname}-default-routetable"
        env = var.env
    }
    default_route_table_id = aws_vpc.my_vpc.default_route_table_id
   
}
resource "aws_route" "default_internet_access" {
  route_table_id         = aws_default_route_table.default_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.projectname}-igw"
    env = var.env
  }
}





resource "aws_security_group" "default_sg" {
    vpc_id = aws_vpc.my_vpc.id
    name = "${var.projectname}-default-sg"
    ingress {
        
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        
        }
        ingress {
            from_port = 80
            to_port = 80
            protocol = "tcp"     
          cidr_blocks = ["0.0.0.0/0"]
        }

        ingress{
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
        
    
    egress { 
        
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    
}


  