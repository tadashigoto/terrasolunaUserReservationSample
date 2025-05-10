Terasoluna Tour Reservation Docker 環境

このリポジトリは、Terasoluna Tour Reservation サンプルアプリを Docker + Docker Compose で動作させるための構成ファイルと初期化スクリプトを含んでいます。

🚀 プロジェクト概要

アプリケーション: Terasoluna Tour Reservation (Spring Framework / JSP)

ビルド: Maven

Web サーバ: Apache Tomcat 9

DB: PostgreSQL 16

コンテナ管理: Docker / Docker Compose

📋 前提条件

Docker 20.10 以上

Docker Compose v2 以上

ポート 8080, 5432 が空いていること（別ポート使用可）

🔧 セットアップ手順

リポジトリをクローン

git clone https://github.com/<your-org>/terasoluna-tourreservation.git
cd terasoluna-tourreservation

SQL 初期化スクリプトを配置

terasoluna-tourreservation-initdb/src/main/sqls/postgres/ 以下の .sql が /docker-entrypoint-initdb.d にマウントされています。

必要に応じて initdb フォルダを作成し、独自の SQL を追加してください。

Docker イメージのビルド

docker compose build

コンテナの起動

docker compose up -d

動作確認

ブラウザで http://localhost:8080/ にアクセスし、アプリのトップページが表示されることを確認します。

コンテナ停止／削除

docker compose down        # コンテナ停止
docker compose down -v     # ボリューム（DB データ）も削除

🗂 ディレクトリ構成

├─Dockerfile
├─docker-compose.yml
├─context.xml            # JNDI データソース設定
├─terasoluna-tourreservation-domain
├─terasoluna-tourreservation-web
├─terasoluna-tourreservation-initdb
└─terasoluna-tourreservation-env

✏️ CRUD 機能追加

名前・年齢・メールアドレスの Person エンティティ CRUD を追加したい場合:

initdb に SQL (00300_create_person.sql, 00310_insert_person.sql) を追加

Domain レイヤに Person.java, PersonRepository, PersonService を実装

Web レイヤに PersonForm, PersonController, JSP を作成

メニューリンクを追加→再ビルド＆再起動

💾 バックアップ／復元

ソース一式: Git で管理

DB 初期化: initdb の SQL で自動再生成

実データ残存: pg_dump でダンプ取得

📄 ライセンス

MIT License

