variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "ports" {
  type        = list(number)
  default     = [80, 443, 22]
  description = "List of ports to open on the EC2 instance"
}
