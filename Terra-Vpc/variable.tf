variable "region" {
    default = "ap-northeast-1"
}

variable "cidr_block_vpc" {
    type = string
    default = "10.0.0.0/16"
    description = "value of cidr block for vpc"
}

variable "public_subnet" {
    type = string
    default = "10.0.1.0/24"
    description = "value of cidr block for public subnet"
}

variable "private_subnet" {
    type = string
    default = "10.0.2.0/24"
    description = "value of cidr block for private subnet"
}

variable "security_group_name" {
    type = list(number)
    default = [22, 80, 443, 8080]
    description = "value of security group name"
}


variable "instance_type" {
    default = "t2.micro"
    type = string
    description = "value of instance type"
}

variable "instance_ami" {
    default = "ami-0d52744d6551d851e"
    type = string
    description = "value of instance ami"
}