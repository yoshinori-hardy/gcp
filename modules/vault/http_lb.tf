resource "google_compute_global_forwarding_rule" "vault" {
  name       = "${var.name}-rule"
  target     = "${google_compute_target_http_proxy.vault.self_link}"
  port_range = "${var.vault_port}"
}

resource "google_compute_target_http_proxy" "vault" {
  name        = "${var.name}-http-proxy"
  description = "Forward traffic to the vault server"
  url_map     = "${google_compute_url_map.vault.self_link}"
  depends_on  = ["google_compute_url_map.vault"]
}

resource "google_compute_url_map" "vault" {
  name            = "${var.name}-loadbalancer"
  description     = "match all routes to dev app servers"
  default_service = "${google_compute_backend_service.lp.self_link}"
}

resource "google_compute_backend_service" "lp" {
  name        = "${var.name}-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 2

  backend {
    group = "${google_compute_region_instance_group_manager.vault-servers.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.vault.self_link}"]
}

resource "google_compute_http_health_check" "vault" {
  name               = "${var.name}-hc-http"
  request_path       = "${var.health-check}"
  check_interval_sec = 5
  timeout_sec        = 3
}
