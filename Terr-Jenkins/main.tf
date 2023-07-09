terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
    required_version = ">= 0.14.0"
}

locals {
    region = "ap-northeast-1"
    ami = "ami-0d52744d6551d851e"
    instance_type = "t2.micro"
    vpc_id = "vpc-069a33622ae53053e"
    subent_id = "subnet-039c4b3a8313132f2"
    security_group_id = "sg-0ec427ca90c6e49ac"
    instance_name = "Jenkins-Server-Instance"
}

resource "aws_key_pair" "Jenkins-Server" {
    key_name = "Jenkins-Server"
    public_key = file("C:\\Users\\amult\\.ssh\\id_rsa.pub")
    tags = {
            Name = "Jenkins-Server"
    }
}



provider "aws" {
    region = local.region
}
resource "aws_instance" "Jenkins_server" {
    ami = local.ami
    key_name = aws_key_pair.Jenkins-Server.key_name
    vpc_security_group_ids = [local.security_group_id]
    instance_type = local.instance_type
    subnet_id = local.subent_id
    tags = {
        Name = local.instance_name
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("C:\\Users\\amult\\.ssh\\id_rsa")
        host = self.public_ip
    }
    provisioner "file" {
        source = "user_data.sh"
        destination = "/tmp/user_data.sh"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/user_data.sh",
            "sudo /tmp/user_data.sh"
        ]
    }

}

output "public_ip" {
    value = aws_instance.Jenkins_server.public_ip
}

output "public_dns" {
    value = aws_instance.Jenkins_server.public_dns
}
