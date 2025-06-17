terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}


provider "openstack" {
  auth_url              =   var.OS_AUTH_URL            # Keystone-endpoint
  user_name             =   var.OS_USERNAME            # OS_USERNAME
  password              =   var.OS_PASSWORD            # OS_PASSWORD
  user_domain_name      =   var.OS_USER_DOMAIN_NAME    # OS_USER_DOMAIN_NAME
  project_id            =   var.OS_PROJECT_ID
  project_domain_id     =   var.OS_PROJECT_DOMAIN_ID   # OS_PROJECT_DOMAIN_ID
  tenant_time           =   var.OS_PROJECT_NAME
  region                =   var.OS_REGION_NAME         # OS_REGION_NAME
  endpoint_type         =   var.OS_INTERFACE           # OS_ENDPOINT_TYPE i env
}
