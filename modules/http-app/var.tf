variable "name" {
  default     = "un-named"
  description = "The name of the app"
}

variable "region" {
  description = "region we're working in"
}

variable "listener_port" {
  description = "Port to send app traffic to"
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

variable "disk_size_gb" {
  description = "Size in Gb of the data vol"
  default     = "10"
}

variable "source_image" {
  description = "The boot disk image to use"
}

variable "sub-map" {
  type        = "map"
  description  = "imported subnet map"
}

variable local_cmd_create {
  description = "Command to run on create as local-exec provisioner for the instance group manager."
  default     = ":"
}

variable local_cmd_destroy {
  description = "Command to run on destroy as local-exec provisioner for the instance group manager."
  default     = ":"
}
