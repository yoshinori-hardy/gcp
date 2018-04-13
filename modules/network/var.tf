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

variable "can_ip_forward" {
  description = "Allow ip forwarding"
}

variable local_cmd_create {
  description = "Command to run on create as local-exec provisioner for the instance group manager."
  default     = ":"
}

variable local_cmd_destroy {
  description = "Command to run on destroy as local-exec provisioner for the instance group manager."
  default     = ":"
}
