resource "aws_instance" "roboshop" {
    ami = var.ami_id
    count = 4
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow-all.id]
  tags = merge(
    var.common_tags,
    {
      Component = var.instance[count.index]
    }
  )
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