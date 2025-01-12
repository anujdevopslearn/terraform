terraform { 
  cloud { 
    
    organization = "AnujDevOps" 

    workspaces { 
      name = "Development" 
    } 
  } 
}

resource "aws_instance" "jenkins_instance" {
  for_each = { for instance in var.instance_details : instance.instance_name => instance }
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = each.key
  }
  ami = each.value.ami_id
}




variable "instance_details" {
  type = list(object({
    instance_name   = string
    ami_id     = string
  }))
  default = [
    { instance_name = "Ubuntu 24.04", ami_id = "ami-0e2c8caa4b6378d8c" },
    { instance_name = "Amazon Linux 2", ami_id = "ami-05576a079321f21f8" },
    { instance_name = "Amazon Linux", ami_id = "ami-05576a079321f21f8" }
  ]
}
