resource "aws_instance" "openvpn" {
    ami = var.ami_openvpn
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.openvpn-sg.id]
    user_data = <<-EOF
        admin_user=${var.server_username}
        admin_pw=${var.server_password}
    EOF
    tags = {
        Name = "openvpn"
    }
}