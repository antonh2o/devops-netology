output "app" {
  value = "${yandex_compute_instance.app.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.app,
  ]

}
output "db01_ip" {
  value = "${yandex_compute_instance.db01.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.db01,
  ]

}
output "db02_ip" {
  value = "${yandex_compute_instance.db02.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.db02
  ]

}
output "gitlab_ip" {
  value = "${yandex_compute_instance.gitlab.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.gitlab,
  ]

}
output "monitoring_ip" {
  value = "${yandex_compute_instance.monitoring.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.monitoring,
  ]

}
output "nginx_ip" {
  value = "${yandex_compute_instance.nginx.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.nginx,
  ]

}
output "runner_ip" {
  value = "${yandex_compute_instance.runner.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.runner,
  ]

}


