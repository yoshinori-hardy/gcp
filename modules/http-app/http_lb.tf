resource "google_compute_global_forwarding_rule" "app-forward-rule" {
  name       = "${var.name}-forwarder"
  target     = "${google_compute_target_http_proxy.app-proxy.self_link}"
  port_range = "${var.listener_port}"
}

resource "google_compute_target_http_proxy" "app-proxy" {
  name        = "${var.name}-http-proxy"
  description = "Forward traffic to the app server"
  url_map     = "${google_compute_url_map.app-map.self_link}"
  depends_on  = ["google_compute_url_map.app-map"]
}

resource "google_compute_url_map" "app-map" {
  name            = "${var.name}-loadbalancer"
  description     = "match all routes to app servers"
  default_service = "${google_compute_backend_service.app.self_link}"
}

resource "google_compute_backend_service" "app" {
  name        = "${var.name}-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 2

  backend {
    group = "${google_compute_region_instance_group_manager.app-servers.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.app-hc.self_link}"]
}

resource "google_compute_http_health_check" "app-hc" {
  name               = "${var.name}-hc-http"
  request_path       = "${var.health-check}"
  check_interval_sec = 5
  timeout_sec        = 3
}
