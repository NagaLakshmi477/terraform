variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
  
}

variable "ec2_tags" {
    type = map
    default = {
        Name = "roboshop"
    }
  
}

variable "sg_name" {
    default = "file-allow-all"
  
}

variable "sg_description" {
    default = "allowing all traffic from outside"
  
}

variable "from_port" {
    default = 0
  
}

variable "to_port" {
  default = 0
}

variable "cidr_blocks" {
    default = ["0.0.0.0/0"]
  
}

variable "protocol" {
    default = "-1"
  
}

variable "sg_tags" {
  default = {
    Name = "allow-all"
  }
}

variable "zone_id" {
  default = "Z0641495UVSN81Z3A8D7"
}

variable "instance" {
 
  default = ["mongodb","redis","mysql","rabbitmq"]
}

variable "domain_name" {
  default = "lakshmireddy.site"
}