resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 100"
  }

  depends_on = [
    local_file.prod
  ]
}

resource "null_resource" "provision" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../inventory/prod.yml ../provision.yml"
  }

  depends_on = [
    null_resource.wait
  ]
}
resource "null_resource" "cluster" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../inventory/prod.yml ../site.yml"
  }

  depends_on = [
    null_resource.wait
  ]
}
