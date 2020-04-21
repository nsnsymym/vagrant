## vagrantの使い方

### 動作手順
1. [VirtualBoxのインストール](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrantのインストール](https://www.vagrantup.com/downloads.html)
3. コマンドプロンプト(win) or ターミナル(mac)を開いて`vagrant -v`を実行。インストールされていることを確認
4. `vagrant plugin install vagrant-vbguest`を実行。共有フォルダを使うためのプラグインをインストール
5. `vagrant plugin install vagrant-winnfsd`を実行。winnfsを使うためのプラグインをインストール
6. `cd vagrant_test`（ディレクトリのダウンロード先による）このディレクトリがあるフォルダに移動。
7. `vagrant up`Vagrantfileを実行してVMを立ち上げる。（初回は時間がかかる）
8. `vagrant ssh`これで立ち上げたVMに対してssh接続できる
9. `vagrant halt`VMをシャットダウンする

### 構成
- CenOS7
- php7.4
- mysql5.7
- apache2.4

### VirtualBox, Vagrantとは
VirtualBoxはホストOSの上にゲストOSとして新たに任意のOSを立ち上げることのできる仮想化ソフト。
VagrantはVirtualBoxの立ち上げ、設定などもろもろ自動化する為のツール。

### その他
- 共有フォルダはホスト側はVagrantfileのあるディレクトリでゲスト側は/var/www/html
- DocumentRoot /var/www/html
- 実際にコードをいじる時は共有フォルダ内をいじる
- git cloneはローカル側の共有フォルダにする
- `vagrant ssh-config`でデフォで作られるssh設定を確認できる
- composerなどのコマンドを使うときは`vagrant ssh`でVM内に入って叩く
- DBクライアントにはsshで接続する
- [その他vagrantコマンド](https://qiita.com/oreo3@github/items/4054a4120ccc249676d9)
- vagrantのバージョンが最新でないと起動しないようなので注意
