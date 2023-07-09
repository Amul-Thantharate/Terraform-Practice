resource "aws_security_group" "openvpn-sg" {
    name = "openvpn-sg"
    description = "Security group for OpenVPN"
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
        Name = "openvpn-sg"
    }
}
