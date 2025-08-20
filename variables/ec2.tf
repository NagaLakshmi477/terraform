resource "aws_instance" "roboshop" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow-all.id]
  tags = var.ec2_tags
}

resource "aws_security_group" "allow-all" {
    name = var.sg_name
    description = "allowing all traffic"
    ingress {
        from_port = var.from_port
        to_port = var.to_port
        protocol = var.protocol
        cidr_blocks = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port = var.from_port
        to_port = var.to_port
        protocol = var.protocol
        cidr_blocks = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]  
    }
  tags = {
    Name= "allow-all-t"
  }
}