variable "OS_AUTH_URL" {
  description = "OpenStack Keystone Identity API URL"
  type        = string
}

variable "OS_PROJECT_ID" {
  description = "Projekt-ID i OpenStack"
  type        = string
}

variable "OS_PROJECT_NAME" {
  description = "Projekt-namn i OpenStack"
  type        = string
}

variable "OS_USER_DOMAIN_NAME" {
  description = "User Domain Name (Keystone v3)"
  type        = string
}

variable "OS_PROJECT_DOMAIN_ID" {
  description = "Project Domain ID (Keystone v3)"
  type        = string
}

variable "OS_USERNAME" {
  description = "OpenStack-användarnamn"
  type        = string
}

variable "OS_PASSWORD" {
  description = "OpenStack-lösenord"
  type        = string
  sensitive   = true
}

variable "OS_REGION_NAME" {
  description = "Region i OpenStack-miljön"
  type        = string
  default     = null
}

variable "OS_INTERFACE" {
  description = "Vilken interface-typ som används (public/admin)"
  type        = string
  default     = null
}

variable "OS_IDENTITY_API_VERSION" {
  description = "Keystone API-version (vanligen 3)"
  type        = string
  default     = "3"
}
