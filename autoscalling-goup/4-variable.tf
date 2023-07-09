variable "aws_region" {
    default = "us-east-1"
}

variable "aws_ami" {
    default = "ami-053b0d53c279acc90"
}

variable "aws_instance_type" {
    default = "t2.micro"
}

variable "aws_key_name" {
    default = "passbolt"
}

variable "port" {
    description = "The port the application will listen on"
    type = list(number)
    default = [80, 443, 22, 8080] # HTTP, HTTPS, SSH
}
