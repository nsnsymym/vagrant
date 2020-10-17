Vagrant.configure("2") do |config|

  Encoding.default_external = 'UTF-8'
  # centos7をバージョン指定してインストール
  config.vm.box = "centos/7"
  config.vm.box_version = "1905.1"

  config.vm.hostname = 'sample'

  # HTTPのポートフォワーディング。http://localhost:8090でアクセスできる
  config.vm.network "forwarded_port", guest: 8090, host: 80

  # ホストOSからのみhttp://192.168.3.100でアクセスできる
  config.vm.network "private_network", ip: "192.168.3.100"

  # 共有フォルダの設定（ホストの/sync配下とゲストの/var/www/html配下を共有）
    # Windowsの場合は以下のコメントアウトを外す
    # config.winnfsd.uid = 1
    # config.winnfsd.gid = 1
  config.vm.synced_folder "./sync", "/var/www/html", type: "nfs", nfs_export: true

  # ツールをvirtualboxに指定
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "2048"
  end

  # その他のインストール項目をinstall.shから読み込む
  config.ssh.insert_key = false
  config.vm.provision :shell, keep_color: true, path: "install.sh"
end
