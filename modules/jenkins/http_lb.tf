resource "google_compute_global_forwarding_rule" "jenkins" {
  name       = "${var.name}-rule"
  target     = "${google_compute_target_http_proxy.jenkins.self_link}"
  port_range = "${var.jenkins_port}"
}

resource "google_compute_target_http_proxy" "jenkins" {
  name        = "${var.name}-http-proxy"
  description = "Forward traffic to the jenkins server"
  url_map     = "${google_compute_url_map.jenkins.self_link}"
  depends_on  = ["google_compute_url_map.jenkins"]
}

resource "google_compute_url_map" "jenkins" {
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
    group = "${google_compute_region_instance_group_manager.jenkins-servers.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.jenkins.self_link}"]
}

resource "google_compute_http_health_check" "jenkins" {
  name               = "${var.name}-hc-http"
  request_path       = "/health_checks.html"
  check_interval_sec = 5
  timeout_sec        = 2
}
