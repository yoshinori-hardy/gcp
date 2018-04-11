## Custom Security Roles

As custom role name can only be used once per project, they should be managed and
maintained independantly of the Server and Network infrastructure.  If they were
re-created with random names at each infra build we would not be able to use human
readable names.  This also provides the security team a single place to manage custom
security roles.  These roles should be created immediately after the project and
prior to running the remaining infrastructure build.

## Firewall rules

Mange firewall rules based on tags, ip and protocols

```
resource "google_compute_firewall" "rule-name" {
  name    = "rule-name"
  network = "${google_compute_network.dop-vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["fw-ssh"]
}
```
