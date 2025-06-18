
resource "openstack_compute_keypair_v2" "wg" {
  name       = "wireguard"
  public_key = chomp(file("~/wireguard.pub")) # Replace with the path to your ssh pubkey
}

module external-sg {
   source = "github.com/safespring-community/terraform-modules/v2-compute-security-group?ref=v0.6.1"
   name = "wg-external"
   description = "External access to wireguard server"
   rules = [
     {
       ip_protocol = "udp"
       to_port = "51820"
       from_port = "51820"
       cidr = "0.0.0.0/0" # Change this' to tighten up access to wirguard port
     },
     {
       ip_protocol = "tcp"
       to_port = "22"
       from_port = "22"
       cidr = "0.0.0.0/0" # Change this to tighten up access to ssh
     }

   ]
}

module internal-sg {
   source = "github.com/safespring-community/terraform-modules/v2-compute-interconnect-security-group?ref=v0.6.1"
   name = "wg-internal"
   description = "Internal access "
}

module wg_server {
  source = "github.com/safespring-community/terraform-modules//v2-compute-local-disk?ref=v0.6.1"
  key_pair_name   = openstack_compute_keypair_v2.wg.name
  security_groups = [ module.internal-sg.name , module.external-sg.name ]
  instance_count  = 1
  prefix          = "wireguard-gateway"
  domain_name     = "local"
  flavor          = "l2.c2r4.100"           # Smallest with local disk, which wg_server module requires
  image           = "ubuntu-20.04"
  network         = "public"
  role            = "wireguard"
}


# Dummy host for testing access to private only instance
#resource "openstack_compute_instance_v2" "dummy" {
#  name            = "private-dummy-host"
#  flavor_name          = "l2.c2r4.100"           # Smallest with local disk, which wg_server module requires
#  image_name        = "ubuntu-20.04"
#  security_groups = [ "wg-internal" ]
#  key_pair        = "wireguard"
#
#  network {
#    name = "private"
#  }
#}

