#cloud-config
bootcmd:
  - nmcli con down "System ens192"
  - nmcli con del "System ens192"
  - nmcli con down ens192
  - nmcli con del ens192
  - nmcli con add type ethernet ifname ${vm_ethernet} con-name ${vm_ethernet} ipv4.method manual ipv4.address ${vm_ip}/24 ipv4.gateway ${guest_gateway} ipv4.dns ${guest_dns}
  - hostnamectl --static set-hostname ${guest_hostname}
  # - nmcli con up ${vm_ethernet}
  # - nmcli general reload
  # - nmcli connection reload

# packages:
#   - containerd.io
#   - vim
#   - bash-completion
#   - chkconfig
#   - net-tools

users:
  - default
  - name: ${vm_username}
    homedir: /home/${vm_username}
    shell: /bin/bash
    system: false
    passwd: 4096$0m282TCqnIk9RpjT$oX1LxK5IQmY5CPeXo0d7MBoddXeWxINyiRXtmdLlMprJ73lEalN4zmDErxm6HKQLeUHLLfba4mUweFhHdYnDZ.
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: false
    ssh_authorized_keys:
      - LLave1
      - Llave2

# write_files:
#   - path: /home/k8sadm/k8s.sh
#     content: |
#       #!/bin/bash
      
#       # ===== AGREGAR MODULOS AL KERNEL =====
#       modprobe br_netfilter ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh overlay

#       # ===== AGREAGR LOS MODULOS AUTOMATICAMENTE (MASTER Y NODOS) =====
#       cat > /etc/modules-load.d/kubernetes.conf << EOF
#       br_netfilter
#       ip_vs
#       ip_vs_rr
#       ip_vs_wrr
#       ip_vs_sh
#       overlay
#       EOF

#       # ===== AGREGAR PARAMETROS AL KERNEL (MASTER Y NODOS) =====
#       cat > /etc/sysctl.d/kubernetes.conf << EOF
#       net.ipv4.ip_forward = 1
#       net.bridge.bridge-nf-call-ip6tables = 1
#       net.bridge.bridge-nf-call-iptables = 1
#       EOF

#       sysctl --system

#       # ===== DESHABILITANDO SWAP (MASTER Y NODOS) =====
#       swapoff -a
#       sed -e '/swap/s/^/#/g' -i /etc/fstab

#       # ===== AGREAGANDO REPOSITORIO DOCKER Y KUBERNETES CON VERSION ESPECIFICA=====
#       dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

#       cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
#       [kubernetes]
#       name=Kubernetes
#       baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
#       enabled=1
#       gpgcheck=1
#       gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
#       EOF
#       dnf makecache

#       # ===== INSTALANDO PAQUETES DE KUBERNETES =====
#       dnf install -y kubelet kubeadm kubectl containerd.io

#       # ===== CONFIGURANDO CONTAINERD =====
#       sh -c "containerd config default > /etc/containerd/config.toml" ; cat /etc/containerd/config.toml

#       # ===== MODIFICAR SystemdCgroup = true DENTRO DE config.toml =====
#       SystemdCgroup = false ==>> SystemdCgroup = true

#       # ===== REGLAS DE COSTAFUEGOS =====
#       firewall-cmd --zone=public --permanent --add-port=6443/tcp
#       firewall-cmd --zone=public --permanent --add-port=8080/tcp
#       firewall-cmd --zone=public --permanent --add-port=30000-32767/tcp
#       firewall-cmd --zone=public --permanent --add-port=2379-2380/tcp
#       firewall-cmd --zone=public --permanent --add-port=10250/tcp
#       firewall-cmd --zone=public --permanent --add-port=10251/tcp
#       firewall-cmd --zone=public --permanent --add-port=10252/tcp
#       firewall-cmd --zone=public --permanent --add-port=10255/tcp
#       firewall-cmd --zone=public --permanent --add-port=10259/tcp
#       firewall-cmd --zone=public --permanent --add-port=5473/tcp
#       firewall-cmd --zone=public --permanent --add-port=443/tcp
#       firewall-cmd --zone=public --permanent --add-port=80/tcp
#       firewall-cmd --zone=public --permanent --add-port=20/tcp
#       firewall-cmd --zone=public --permanent --add-port=21/tcp
#       firewall-cmd --zone=public --permanent --add-port=22/tcp
#       sudo firewall-cmd --reload

#       # ===== HABILITANDO SERVICIOS =====
#       systemctl enable --now containerd
#       systemctl start --now containerd
#       systemctl enable --now kubelet.service

#       # ===== INICIALIZANDO EL MASTER =====
#       kubeadm config images pull
#       kubeadm init --pod-network-cidr=10.244.0.0/16 >/var/log/k8s.sh.log 2>&1

#       echo 'Script k8s.sh creado exitosamente!' >>/var/log/k8s.sh.log 2>&1
#     permissions: '0755'

# runcmd:
#   - [ sh, "/home/ansible/k8s.sh" ]

final_message: "##### SISTEMA CONFIGURADO, TARDO $UPTIME SEGUNDOS LA CONFIGURACION. #####"