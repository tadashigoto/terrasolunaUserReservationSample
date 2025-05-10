# ---------- ビルド段階 ----------
     FROM maven:3.9.7-eclipse-temurin-11 AS build
     WORKDIR /app
     COPY . .
     RUN mvn -B clean package -Dmaven.test.skip=true
     
     
     # ---------- 実行段階 ----------
     FROM tomcat:9.0-jdk11-temurin
     
     # ① WAR を配置
     COPY --from=build /app/terasoluna-tourreservation-web/target/terasoluna-tourreservation-web.war \
          /usr/local/tomcat/webapps/ROOT.war
     
     # ② env のコンフィグ一式を Tomcat 所定ディレクトリへ
     #    （JAR ではなく “configs/tomcat9-postgresql” フォルダ）
     COPY --from=build \
          /app/terasoluna-tourreservation-env/configs/tomcat9-postgresql \
          /opt/tomcat/tomcat/webapps-env-jars/terasoluna-tourreservation-env-tomcat9-postgresql
     
     # ③ JDBC 設定
     COPY context.xml /usr/local/tomcat/conf/context.xml
     
     ENV CATALINA_OPTS="-Xms512m -Xmx512m"
     EXPOSE 8080
     CMD ["catalina.sh","run"]
     