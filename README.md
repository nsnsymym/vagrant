# Vagrantの使い方

### 構成
- CenOS7
- php7.4(7系なら好きに変えられます)
  - composer
- mysql8.0(57か80なら好きに変えられます)
- apache2.4

### Vagrantの初期設定
- [VirtualBoxのインストール](https://www.virtualbox.org/wiki/Downloads)
- [Vagrantのインストール](https://www.vagrantup.com/downloads.html)
- コマンドプロンプト(win) or ターミナル(mac)を開いて`vagratn -v`を実行。インストールされていることを確認
- `vagrant plugin install vagrant-vbguest`を実行。共有フォルダを使うためのプラグインをインストール
- 【Winの場合】`vagrant plugin install vagrant-winnfsd`を実行。winnfsを使うためのプラグインをインストール
- `cd vagrant`（ディレクトリのダウンロード先による）このREADMEがあるフォルダに移動。

### プロジェクトの初期設定
- `git clone [gitのURL] sync`
  - `install.sh`で`composer install`を行っているので最初にプロジェクトの`composer.json`があった方が良い
- `vagrant up` 諸々のミドルウェアの設定から`composer update`まで行う
  - 初回は時間かかるのでコーヒーでも飲んで待っててください。
- `vagrant ssh` ゲストOSにssh接続
- `php artisan migrate`(Laravel) or `./bin/cake migrations migrate`(Cake)
- `php artisan db:seed` or `./bin/cake migrations seed`

### コマンドをいくつか
- 閉じる時
    - `vagrant halt`
- 環境を壊す時
    - `vagrant destroy`
- 再起動
    - `vagrant reload`
- `install.sh`だけ再実行
    - `vagrant provision`

### 作成されるDBの情報
- DB Host: `localhost`
- DB名: `db`
- ユーザー名: `user`
- パスワード: `passwordPASSWORD@999`

### その他
- 共有フォルダはホスト側は`/sync`配下でゲスト側は`/var/www/html`配下
- `DocumentRoot /var/www/html`
- ログイン時に`/var/www/html`にいくようになってる
- 実際にコードをいじる時は共有フォルダ内をいじる
- git cloneはローカル側の共有フォルダにする
- `vagrant ssh-config`でデフォで作られるssh設定を確認できる
- composerなどのコマンドを使うときは`vagrant ssh`でVM内に入って叩く
- DBクライアントはssh経由で接続する
    - ssh情報
    - Server: `192.168.3.100`(Vagrantfileのprivate IP)
    - User: `vagrant`
    - SSH key: `~/.vagrant.d/insecure_private_key`(ホストマシンのローカルに自動生成される)
- [その他vagrantコマンド](https://qiita.com/oreo3@github/items/4054a4120ccc249676d9)
- vagrantのバージョンが最新でないと起動しないようなので注意
