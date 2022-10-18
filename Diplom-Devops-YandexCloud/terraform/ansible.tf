resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 120"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "add_ssh_nginx" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/provision.yml"
  }

  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "node_exporter" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/node_exporter.yml"
  }

 depends_on = [
    null_resource.add_ssh_nginx
  ]
}

resource "null_resource" "db" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/mysql-cluster.yml"
  }

 depends_on = [
    null_resource.add_ssh_nginx
  ]
}

resource "null_resource" "wordpress" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/wordpress.yml"
  }

 depends_on = [
    null_resource.db
  ]
}

resource "null_resource" "gitlab" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/gitlab.yml"
  }

 depends_on = [
    null_resource.wordpress
  ]
}

resource "null_resource" "runner" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/runner.yml"
  }

 depends_on = [
    null_resource.gitlab
  ]
}

resource "null_resource" "monitoring" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/monitoring.yml"
  }

 depends_on = [
    null_resource.gitlab
  ]
}


resource "null_resource" "revproxy_nginx" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/revproxy.yml"
  }

  depends_on = [
    null_resource.monitoring
  ]
}


