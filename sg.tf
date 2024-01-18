resource "aws_security_group" "public-sg" {
  name        = "public-sg"
  description = "Allow 22 port inbound traffic"
  vpc_id      = module.vpc.vpc_id

# 22 port is ope for all
  ingress {
    description      = "22 port open"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "http-service ports"
    cidr_blocks = ["0.0.0.0/0"]
  }

  


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "public-sg"
  }
}


resource "aws_security_group" "private-sg" {
  name        = "private-sg"
  description = "all ports open for vpc"
  vpc_id      = module.vpc.vpc_id

# all ports are open within the vpc
  ingress {
    description      = "all ports open for vpc"
    from_port        =0 
    to_port          = 65534
    protocol         = "tcp"
    cidr_blocks      = ["10.100.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "private-sg"
  }
}


 
