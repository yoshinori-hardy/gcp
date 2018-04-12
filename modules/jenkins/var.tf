variable "name" {
  default     = "jenkins"
  description = "The name of the app"
}

variable "jenkins_port" {
  description = "Port to send Jenkins traffic to"
  default     = "8080"
}

variable "target_size" {
  description = "target size of jenkins instance group"
  default     = "3"
}

variable "machine_type" {
  description = "Machine type to use"
  default     = "g1-small"
}

variable "source_image" {
  description = "The boot disk image to use"
}

variable "subnet_jenkins" {
  description = "The subnet to place Jenkins servers in"
  default     = "sub-app-0"
}
