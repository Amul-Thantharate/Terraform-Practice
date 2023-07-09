resource "aws_security_group" "allow_trafic" {
    name = "my-prod-sg"
    description = "Allow HTTP and SSH inbound traffic"
    dynamic "ingress" {
        for_each = var.port
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
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "my-prod-sg"
    }
}

