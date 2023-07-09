variable "region" {
    default = "us-east-1"
}

variable "ami_openvpn" {
    type = string
    description = "AMI for OpenVPN"
    default = "ami-0f95ee6f985388d58"
}

variable "instance_type" {
    type = string
    description = "Instance type for OpenVPN"
    default = "t2.micro"
}

variable "port" {
    type = list(number)
    description = "Port for OpenVPN"
    default = [22,443,943,945,1194]
}

variable "server_username" {
    type = string
    description = "Username for OpenVPN"
    default = "openvpn"
}

variable "server_password" {
    type = string
    description = "Password for OpenVPN"
    default = "password"
}

variable "key_name" {
    type = string
    description = "Key name for OpenVPN"
    default = "passbolt"
}
