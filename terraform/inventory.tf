resource "local_file" "inventory" {
  content = <<-DOC

    [proxy]
    proxy.netology.yc ansible_host=${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}

    [db-master]
    db01.netology.yc ansible_host=${yandex_compute_instance.db01.network_interface.0.ip_address}

    [db-slave]
    db02.netology.yc ansible_host=${yandex_compute_instance.db02.network_interface.0.ip_address}

    [app]
    app.netology.yc ansible_host=${yandex_compute_instance.app.network_interface.0.ip_address}
    
    [gitlab]
    gitlab.netology.yc ansible_host=${yandex_compute_instance.gitlab.network_interface.0.ip_address}
    
    [runner]
    runner.netology.yc ansible_host=${yandex_compute_instance.runner.network_interface.0.ip_address}
    
    [monitoring]
    monitoring.netology.yc ansible_host=${yandex_compute_instance.monitoring.network_interface.0.ip_address}
    
    [db-master:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -q ubuntu@${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"'
    
    [db-slave:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -q ubuntu@${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"'

    [app:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -q ubuntu@${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"'

    [gitlab:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -q ubuntu@${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"'

    [runner:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -q ubuntu@${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"'
   
    [monitoring:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -q ubuntu@${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"'
    DOC
  filename = "../ansible/inventory"

  depends_on = [
    yandex_compute_instance.proxy,
    yandex_compute_instance.db01,
    yandex_compute_instance.db02,
    yandex_compute_instance.app,
    yandex_compute_instance.gitlab,
    yandex_compute_instance.runner,
    yandex_compute_instance.monitoring
  ]
}
