provider "aws" {
    region     = "${var.region}"
    
}


resource "aws_instance" "IP_example" {
    ami           = lookup(var.ami_id, var.region)
    instance_type = var.instance_type
    subnet_id     = aws_subnet.public_1.id

    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    private_ip = "10.0.1.10"
    key_name = aws_key_pair.terraform.key_name
    user_data = <<EOF
    #! /bin/bash
                sudo yum update -y
    sudo yum install -y httpd.x86_64
    sudo service httpd start
    sudo service httpd enable
    echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
    EOF

    tags = {
    Name = "Private_IP"
    }
}

resource "aws_eip" "eip" {
    instance = aws_instance.IP_example.id
    vpc      = true
}

resource "aws_key_pair" "terraform" {
    key_name   = "terraform"
    public_key = file("~/.ssh/id_rsa.pub")
    tags = {
    Name = "terraform"
    }
}

output "public_ip" {
    value = aws_eip.eip.public_ip
}