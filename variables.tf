variable "allow_ssh_from_v4" {
  type = list
  default = [] 
}

variable "allow_wg_from_v4" {
  type = list
  default = [] 
}

variable "public_key_path" {
  description = "The path of the ssh pub key"
  default     = "~/.ssh/id_rsa.pub"
}
