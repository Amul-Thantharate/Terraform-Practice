locals {
  instance_type           = "t2.micro"
  instance_ami            = "ami-0cfc97bf81f2eadc4"
  instance_key_name       = "Game"
  instance_security_group = "alb-demo-sg"

}

resource "aws_instance" "web-1" {
  count = 2
  ami                    = local.instance_ami
  instance_type          = local.instance_type
  key_name               = local.instance_key_name
  vpc_security_group_ids = [local.instance_security_group]
  
  user_data              = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "Hello World from $(hostname -f)" > /var/www/html/index.html
    EOF
  tags = {
    Name = "web-1-${count.index}"
    enable = true
  }
}
