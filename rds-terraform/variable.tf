variable "region" {
    default     = "us-east-1"
    description = "The region in which AWS operations will take place."
}

variable "ports" {
    default     = [80, 443]
    description = "The ports to open for inbound traffic."
}

variable "ports_database" {
    default     = [3306]
    description = "The ports to open for inbound traffic."
}