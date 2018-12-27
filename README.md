※期間などは特に設定していませんので、ご本人のお仕事との兼ね合いでご自身で設定しご提出ください。（提出予定日は事前にお知らせください。）


------------------------------------------------------------------------------------------------------
webエンジニア版／スキルチェック


■以下を全て満たす Web アプリケーションを作成し、リポジトリの URL(担当者がアクセス可能なもの)を教えてください

デモサイトがある場合はその URL やログインアカウントもお願いします

また、着手前に完成予定日をお知らせください

(着手後の変更ももちろん可能です。同様にお知らせください)

コードでの自己アピールの場と思って、好きなように実装してください

* Rails (最新版を推奨) を使っていること
=> Rails 5.2.2 を使用しました。

* RSpec によるテストを書いていること
=> users_spec.rb でユーザ登録部分のテストを書きました。

* ユーザ認証を行っていること
=> rails標準機能の has_secure_password を使用しました。

* has_many through を使用していること
=> question と category で使用しました。(すいません、時間の関係で登録画面での対応が対応途中です。)

* DB(RDB) にたいする CRU 操作を行うこと
=> ユーザー登録、編集、カテゴリ管理、お題管理でMySQLにアクセスしています。

また、以下も添えてください

* 作った Web アプリケーションのアピールポイント
→ Materialデザインを取り入れました。(MATERIAL COMPONENTS FOR THE WEB)
→ クラウドサーバを契約してisoイメージから CentOS7, MySQL8, Ruby2.5をインストールしサーバを立ち上げました
→ドメインを取得し設定しました zir.jp
→Let's Encryptの証明書を取得設定しました。

* 苦労した点
・WindowsでVisualStudioCodeを使用して開発環境を作る際、
制限ユーザだとうまく動作しない部分が多々あり、
文字コードの問題もあり時間を要しました。
・はじめてMATERIAL COMPONENTS FOR THE WEBを使用したので、
使い方を把握するまで時間を要しました。

* 工夫した点
・日本語を ja.yml に集約し多言語対応しやすいよう留意しました。
・コード中の文字列が少なくなるようにシンボルを多用しました。

* その他感想など
・Rails2からしばらくRubyをさわっていなかったため、
Rails5になれるのに時間を要しました。
・JavaのSpring等のフレームワークで開発するほうが
静的チェックや定義元・参照先参照、識別子の一括リネーム等ができるので
やりやすいと感じました。
・トータルの作業時間はおよそ20時間でした。


------------------------------------------------------------------------------------------------------ 
以下に作業メモを残しておきます。

作業PC: Windows 10, Corei5, 32GB, SSD512GB

Visual Studio Code をダウンロードし解凍(c:\bin\VSCode-win32-x64-1.30.1)
https://code.visualstudio.com/download

Ruby+Devkit(2.5.3p105)をインストール(デフォルトのインストール先)
https://rubyinstaller.org/downloads/

MySQL(8.0.13)のzipをダウンロードし解凍(c:\bin\mysql-8.0.13-winx64)
https://dev.mysql.com/downloads/mysql/

DB初期化
mysqld --initialize
ログ(data\PC名.err)からルートパスワードを調べる

コンソールで起動
mysqld --console

接続
mysql -uroot -p調べたパスワード

パスワード変更
ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '新しいパスワード';


railsをインストール
gem update --system
gem install mysql2
gem install rails
gem install ruby-debug-ide

Webアプリケーション作成
cd /d c:\dev
rails new quiz -d mysql

環境変数を設定
QUIZ_DATABASE_PASSWORD に新しく設定したrootのパスワードを設定

VisualStudioCodeを起動しc:\dev\quizを開く

DB設定変更
config/database.ymlのdefault.passwordに <%= ENV['QUIZ_DATABASE_PASSWORD'] %> を設定し保存

メニュー Terminal/New Terminal を開く

データベース作成
rails db:create

サーバ起動
rails s

ブラウザで http://localhost:3000/ を開きYay!You're on Rails!が表示されることを確認

テーブル作成
rails g model User name:string mail:string password_digest:string token:string
rails g model Question question:string answer:string hint:string comment:string
rails g model Category name:string
rails g model CategoryQuestion category_id:integer question_id:integer
rails db:migrate
rails db:migrate RAILS_ENV=test

コントローラ作成
rails g controller Users new
rails g controller Questions

トップページの作成
config/routes.rbに
get "/" => "questions/index"
を追加
app/views/questionsに
index.html.erb
を追加

[デバッグ開始]

拡張機能のrubyをインストール
デバッグ開始を押し rails serverを選択

[テストデータ作成]
MySQL management tool プラグインを入れて作成されたテーブルを確認
insert into quiz_development.questions(question, answer, hint, comment, created_at, updated_at) values('日本一高い山は？', '富士山', '漢字三文字です', '静岡県と山梨県にまたがる活火山で標高は3776mです。2番目は山梨県にある北岳で3193mです。', now(), now());
select * from quiz_development.questions;

[ajax有効化]
app/assets/application.jsに
//= require jquery
を追加

Gemfileに
gem 'jquery-rails'
を追加

ターミナルで
bundle install
を実行


[デプロイ]
CentOS7 minimumをインストール
sshで接続設定
sudo yum update
sudo yum install -y git bzip2 gcc openssl-devel readline-devel zlib-devel

rbenvファイルを取得
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

~/.bashrcに追加
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source ~/.bashrc

rbenv install --list
で最新バージョンを調べて

rbenv install バージョン
でインストール

rbenv global バージョン

ruby -vで確認

MySQLをインストール
rpm -Uvh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
yum install mysql-community-server mysql-devel
systemctl start mysqld で起動
systemctl status mysqld で起動確認
systemctl enable mysqld で自動起動有効化

grep 'temporary password' /var/log/mysqld.log でパスワードを調べてログイン
mysql -uroot -p

パスワード変更
ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'root_Password1';

railsインストール
gem update --system
gem install mysql2
gem install rails

80番ポートを開ける
firewall-cmd --permanent --zone public --add-service http
firewall-cmd --reload

環境変数を設定
export PORT=80
export QUIZ_DATABASE_PASSWORD=root_Password1

[証明書取得]
git clone https://github.com/certbot/certbot.git
cd certbot
./certbot-auto certonly --manual -d zir.jp -d *.zir.jp -m nakazawaken1@gmail.com --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01
表示される文字列をtxtレコードを設定
txt _acme-challenge.zir.jp 文字列
nslookup -type=TXT _acme-challenge.zir.jp で設定が表示されるまで待つ

httpsを開ける
firewall-cmd --add-service=https --zone=public --permanent
firewall-cmd --reload

rails s -b 'ssl://0.0.0.0:443?key=/etc/letsencrypt/live/zir.jp/privkey.pem&cert=/etc/letsencrypt/live/zir.jp/fullchain.pem'
