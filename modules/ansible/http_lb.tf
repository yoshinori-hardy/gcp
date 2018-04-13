resource "google_compute_global_forwarding_rule" "ansible" {
  name       = "${var.name}-rule"
  target     = "${google_compute_target_http_proxy.ansible.self_link}"
  port_range = "${var.ansible_port}"
}

resource "google_compute_target_http_proxy" "ansible" {
  name        = "${var.name}-http-proxy"
  description = "Forward traffic to the ansible server"
  url_map     = "${google_compute_url_map.ansible.self_link}"
  depends_on  = ["google_compute_url_map.ansible"]
}

resource "google_compute_url_map" "ansible" {
  name            = "${var.name}-loadbalancer"
  description     = "match all routes to dev app servers"
  default_service = "${google_compute_backend_service.lp.self_link}"
}

resource "google_compute_backend_service" "lp" {
  name        = "${var.name}-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = "${google_compute_region_instance_group_manager.ansible-servers.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.ansible.self_link}"]
}

resource "google_compute_http_health_check" "ansible" {
  name               = "${var.name}-hc-http"
  request_path       = "/health_checks.html"
  check_interval_sec = 5
  timeout_sec        = 2
}
