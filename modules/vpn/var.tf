variable "source_image" {
  description = "The boot disk image to use"
}

variable "machine_type" {
  description = "instance type to use"
}

variable "region" {
  description = "region to deploy into"
}

variable "subnet_1" {
  description = "subnet in zone 1"
}

variable "subnet_2" {
  description = "subnet in zone 2"
}
