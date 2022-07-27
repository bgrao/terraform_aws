resource "aws_instance" "webserver" {
        ami     = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.bgr_public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bgr_security_group.id]
  tags = {
    Name = "web -server"
  }
}

resource "aws_security_group" "bgr_security_group" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.bgr_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bgr_security_group"
  }
}

