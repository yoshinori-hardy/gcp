variable "name" {
  default     = "ansible"
  description = "The name of the app"
}

variable "region" {
  description = "region we're working in"
}

variable "ansible_port" {
  description = "Port to send ansible traffic to"
  default     = "80"
}

variable "health-check" {
  description = "path to http health check"
  default     = "/health-checks.html"
}

variable "target_size" {
  description = "target size of ansible instance group"
  default     = "1"
}

variable "machine_type" {
  description = "Machine type to use"
  default     = "g1-small"
}

variable "source_image" {
  description = "The boot disk image to use"
}

variable "app-subnets" {
  type        = "list"
  description = "imported app subnets from the network module"
}
