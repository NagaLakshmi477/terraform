resource "aws_instance" "roboshop" {
    ami = var.ami_id
    #for_each = var.instance
    for_each = toset(var.instance)
    instance_type = "t3.medium"
    vpc_security_group_ids = [aws_security_group.allow-all.id]
  tags = {
    Name= each.key
}
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
  tags = var.sg_tags
}