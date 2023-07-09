terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "3.38.0"
        }
    }
    required_version = ">= 0.14.9"
}

provider "aws" {
    region = var.region
}

resource "aws_vpc" "my-first-vpc" {
    cidr_block = var.cidr_block_vpc
    tags = {
        Name = "my-first-vpc"
    }
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.my-first-vpc.id
    cidr_block = var.public_subnet
    availability_zone = "ap-northeast-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-1"
    }
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.my-first-vpc.id
    cidr_block = var.private_subnet
    availability_zone = "ap-northeast-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet-1"
    }
}

resource "aws_internet_gateway" "my_internet_gateway" {
    vpc_id = aws_vpc.my-first-vpc.id
    tags = {
        Name = "my-internet-gateway"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my-first-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_internet_gateway.id
    }
    tags = {
        Name = "public-route-table"
    }
}

resource "aws_eip" "my_eip" {
    vpc = true
    tags = {
        Name = "my-eip"
    }
}

resource "aws_nat_gateway" "my_nat_gateway" {
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.public_subnet_1.id
    tags = {
        Name = "my-nat-gateway"
    }
}

resource "aws_route_table_association" "public_route_table_association" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.my-first-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
    }
    tags = {
        Name = "private-route-table"
    }
}


resource "aws_security_group" "for_website" {
    name = "for-website-1"
    description = "for website"
    vpc_id = aws_vpc.my-first-vpc.id
    dynamic "ingress" {
        for_each = var.security_group_name
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
    }
}    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [ "::/0" ]
}
    tags = {
        Name = "for-website-1"
    }
}

resource "aws_key_pair" "website_key_pair" {
    key_name = "website-key-pair"
    public_key = file("C:\\Users\\amult\\.ssh\\id_rsa.pub")
    tags = {
        Name = "website-key-pair"
    }
}

resource "aws_instance" "website_instance" {
    ami = var.instance_ami
    instance_type = var.instance_type
    key_name = aws_key_pair.website_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.for_website.id]
    subnet_id = aws_subnet.public_subnet_1.id
    associate_public_ip_address = true
    ebs_block_device {
        device_name = "/dev/sda1"
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("C:\\Users\\amult\\.ssh\\id_rsa")
        host = self.public_ip
    }
    provisioner "file" {
        source = "website.sh"
        destination = "/home/ubuntu/website.sh"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /home/ubuntu/website.sh",
            "sudo /home/ubuntu/website.sh"
        ]
    }
    provisioner "local-exec" {
        command = "echo ${aws_instance.website_instance.public_ip} > public_ip.txt"
    }
}


resource "aws_ami_copy" "website_ami_copy" {
    name = "website-ami-copy"
    source_ami_id = aws_instance.website_instance.ami
    source_ami_region = var.region
    tags = {
        Name = "website-ami-copy"
    }
}
