resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 150"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "proxy" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/proxy.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "db" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/mysql.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "wp" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/wordpress.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "gitlab" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/gitlab.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "runner" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/runner.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "git_and_runner" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/git_and_runner.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "nodeexporter" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/nodeexporter.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "monitoring" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory ../ansible/monitoring.yml"
  }
  depends_on = [
    null_resource.wait
  ]
}
