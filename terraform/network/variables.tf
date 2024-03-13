variable "region" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "namespace" {
  type = string
}

variable "name" {
  type = string
}

variable "stage" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "max_nats" {
  type = number
}

variable "max_subnet_count" {
  type = number
}

variable "ipv4_primary_cidr_block" {
  type = string
}