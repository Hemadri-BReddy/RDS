variable "sns-topic" {
  type = string
}
variable "fallback-topic" {
  type = string
}
variable "has_email" {
  type    = bool
  default = false
}

variable "email" {
  type    = string
  default = ""
}

variable "has_http_endpoint" {
  type    = bool
  default = false
}

variable "http_endpoint" {
  type    = string
  default = ""
}

variable "has_https_endpoint" {
  type    = bool
  default = false
}

variable "https_endpoint" {
  type    = string
  default = ""
}

variable "has_fallback_email" {
  type    = bool
  default = false
}

variable "fallback_email" {
  type    = string
  default = ""
}
variable "cloudwatch-alarm" {
  type = string
}