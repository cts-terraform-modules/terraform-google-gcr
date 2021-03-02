variable "project" {
  description = "The project ID to deploy to."
}

variable "image_region" {
  description = "The location of the registry. One of ASIA, EU, US or not specified. If not specified, the registry will be global."
  default     = ""
}

variable "public" {
  description = "Whether the GCR is public or not."
  type        = bool
  default     = false
}
