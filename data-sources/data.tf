data "aws_ami" "joindevops"{

    filter {
      name = "name"
      values = ["RHEL-9-DevOps-Practice"]
    }
     filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



# i am printing the output

output "ami_id" {
  value = data.aws_ami.joindevops.id
}