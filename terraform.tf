
resource "openstack_compute_keypair_v2" "wg" {
  name       = "wireguard"
  public_key = "${chomp(file(var.public_key_path))}"
}

resource "openstack_networking_secgroup_v2" "wg" {
  name        = "wireguard-external"
  description = "Wireguard access"
}


resource "openstack_networking_secgroup_rule_v2" "wg-cidr" {
  direction         = "ingress"
  ethertype         = "IPv4"
  count             = "${length(var.allow_wg_from_v4)}"
  security_group_id = "${openstack_networking_secgroup_v2.wg.id}"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51820
  remote_ip_prefix  = "${var.allow_wg_from_v4[count.index]}"
}

resource "openstack_networking_secgroup_rule_v2" "ssh-cidr" {
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = "${openstack_networking_secgroup_v2.wg.id}"
  count             = "${length(var.allow_ssh_from_v4)}"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "${var.allow_ssh_from_v4[count.index]}"
}

resource "openstack_networking_secgroup_rule_v2" "all-icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = "${openstack_networking_secgroup_v2.wg.id}"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_compute_secgroup_v2" "wg-internal" {
  name        = "wireguard-internal"
  description = "Wireguard inter node access"

  rule {
    ip_protocol = "icmp"
    from_port   = "-1"
    to_port     = "-1"
    cidr        = "0.0.0.0/0"
  }

  rule {
    ip_protocol = "tcp"
    from_port   = "1"
    to_port     = "65535"
    self        = true
  }

  rule {
    ip_protocol = "udp"
    from_port   = "1"
    to_port     = "65535"
    self        = true
  }
}

resource "openstack_compute_instance_v2" "wg" {
  name            = "wireguard-gateway"

  flavor_name     = "lb.small"
  image_name        = "ubuntu-20.04"
  security_groups = [ "wireguard-external","wireguard-internal" ]
  key_pair        = "wireguard"
  user_data       = file("./userdata")

  network {
    name = "public"
  }

  metadata = {
    role             = "wireguard"
  }
}

# Dummy host for testing access to private only instance
#resource "openstack_compute_instance_v2" "dummy" {
#  name            = "private-dummy-host"
#
#  flavor_name     = "lb.small"
#  image_name        = "ubuntu-20.04"
#  security_groups = [ "wireguard-internal" ]
#  key_pair        = "wireguard"
#
#  network {
#    name = "private"
#  }
#}

