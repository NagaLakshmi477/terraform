resource "aws_route53_record" "www" {
    count = 4
    zone_id = var.zone_id
    name = "${var.instance[count.index]}.${var.domain_name}"
    ttl = "1"
    type="A"
    records = [aws_instance.roboshop[count.index].public_ip]
    
  
}