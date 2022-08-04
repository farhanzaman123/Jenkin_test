
provider "aws" {
  region  = "us-east-1"
  access_key = "AKIAURC6KPWGZMJS3FJB"
  secret_key = "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"
}


# #1.VPC
# resource "aws_vpc" "my_first_vpc" {
#   cidr_block = "10.0.0.0/16"
#     tags = {
#     Name = "VPC"
#   }
# }

# #2. Internet Gateway
# resource "aws_internet_gateway" "prod-gateway" {
#   vpc_id = aws_vpc.my_first_vpc.id

#   tags = {
#     Name = "prod-gateway"
#   }
# }


# #3. Route Table
# resource "aws_route_table" "Prod-route" {
#   vpc_id = aws_vpc.my_first_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.prod-gateway.id 
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     gateway_id = aws_internet_gateway.prod-gateway.id 
#   }

#   tags = {
#     Name = "Prod-route"
#   }
# }


# # 4.Subnet
# resource "aws_subnet" "first_subnet" {
#   vpc_id     = aws_vpc.my_first_vpc.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone= "us-east-1a"
#   tags = {
#     Name = "Subnet"
#   }
# }


# # 5.Route Table assosciation
# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.first_subnet.id
#   route_table_id = aws_route_table.Prod-route.id
# }


# #6.Security Group
# resource "aws_security_group" "web" {
#   name        = "allow_web_traffic"
#   description = "Allow  Web traffic"
#   vpc_id      = aws_vpc.my_first_vpc.id

#   ingress {
#     description      = "HTTPS"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#     ingress {
#     description      = "HTTP"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#     ingress {
#     description      = "SSH"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }



#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_Web"
#   }
# }

# #7.Network Interface
# resource "aws_network_interface" "web-server-nic" {
#   subnet_id       = aws_subnet.first_subnet.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [aws_security_group.web.id]

# }

# #8.EIP address
# resource "aws_eip" "one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.web-server-nic.id
#   associate_with_private_ip = "10.0.1.50"
#   depends_on = [aws_internet_gateway.prod-gateway]
# }

# #9. Ubuntu Server
resource "aws_instance" "web_server" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "main-key"
}
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt -update -y
#               sudo apt install apache2 -y
#               sudo systemctl start apache2
#               sudo bash -c 'echo your very first web server > /var/www/index.html'
#               EOF
#     tags = {
#         Name="web-server"
#     }




# }