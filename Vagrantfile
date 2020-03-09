Vagrant.configure("2") do |config|

  # -*- coding: utf-8 -*-
  Encoding.default_external = 'UTF-8'
  ###
  # centos7をバージョン指定してインストール
  ###
  config.vm.box = "centos/7"
  config.vm.box_version = "1905.1"

  config.vm.hostname = 'terumo'
  
  ###
  # HTTPのポートを設定
  ###
  # config.vm.network "forwarded_port", guest: 80, host: 8800
  
  ###
  # private_networkを指定するとホストOSからのみアクセスできる
  ###
  config.vm.network "private_network", id: "default-network", type: "dhcp", ip: "192.168.34.0"
  # config.vm.network "private_network", ip: "192.168.33.10"
  
  ###
  # 共有フォルダの設定（VagrantFileのディレクトリと/var/www/htmlを共有）
  # ※rsyncとmutagen(プラグイン)を使用
  # 別でmutagen.ymlを作成する
  ###
  # config.disksize.size = '30GB'
  # config.mutagen.orchestrate = true
  # config.vm.synced_folder "./sync", "/var/www/html", type: "smb",
  #   mount_options: ["vers=3.0"],
  #   smb_username: "nishiyama",
  #   smb_password: "nishiyama"
  config.winnfsd.uid = 1
  config.winnfsd.gid = 1
  config.vm.synced_folder "./sync", "/var/www/html", type: "nfs",
    nfs_export: true
  ###
  # ツールをvirtualboxに指定
  ###
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "2048"
    
    ### シンボリックリンク作成を許可
    # vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  ###
  # その他のインストール項目をinstall.shから読み込む
  ###
  config.ssh.insert_key = false
  config.vm.provision :shell, keep_color: true, path: "install.sh"
end