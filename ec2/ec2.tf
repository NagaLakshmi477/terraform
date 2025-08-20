resource "aws_instance" "roboshop" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow-all.id]
  tags = {
    Name = "hello-world"
  }
}

resource "aws_security_group" "allow-all" {
    name = "allow-all-n"
    description = "allowing all traffic"
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
              from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]  
    }
  tags = {
    Name= "allow-all-t"
  }
}