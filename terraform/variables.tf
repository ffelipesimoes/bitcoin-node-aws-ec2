variable "aws_region" {
  default = "us-west-2"
}

variable "key_pair_name" {
  default = "my-pubkey"
}

variable "public_key_path" {
  default = "/.ssh/id_rsa.pub"
}
variable "instance_type" {
  default = "t2.medium"
}

variable "root_volume_size" {
  default = 500
}