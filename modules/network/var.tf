variable "source_image" {
  description = "The boot disk image to use"
}

variable "machine_type" {
  description = "instance type to use"
}

variable "region" {
  description = "region to deploy into"
}

variable "subnet_dmz" {
  description = "internet facing subnet"
}

variable "subnets" {
  description = "app subnet ranges"
  type        = "list"
}

variable "nat-int-ip" {
  description = "internal IP for the NAT box, needed to set up routes to the interweb"
}
