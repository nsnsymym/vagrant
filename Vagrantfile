Vagrant.configure("2") do |config|

  # -*- coding: utf-8 -*-
  Encoding.default_external = 'UTF-8'
  ###
  # centos7をバージョン指定してインストール
  ###
  config.vm.box = "centos/7"
  config.vm.box_version = "1905.1"

  config.vm.hostname = 'sample'
  
  ###
  # HTTPのポートを設定
  ###
  config.vm.network "forwarded_port", guest: 80, host: 8800
  
  ###
  # private_networkを指定するとホストOSからのみアクセスできる
  ###
  config.vm.network "private_network", ip: "192.168.33.10"
  
  ###
  # 共有フォルダの設定（VagrantFileのディレクトリと/var/www/htmlを共有）
  ###
  config.vm.synced_folder "./sync", "/var/www/html", type: "nfs",
    nfs_export: true

  ###
  # ツールをvirtualboxに指定
  ###
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "2048"    
  end

  ###
  # その他のインストール項目をinstall.shから読み込む
  ###
  config.ssh.insert_key = false
  config.vm.provision :shell, keep_color: true, path: "install.sh"
end