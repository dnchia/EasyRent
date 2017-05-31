FROM java:8
VOLUME /tmp /var/easyrent /var/lucene/indexes
ADD ./target/easy-rent-*.war app.war
EXPOSE 8080
RUN bash -c 'touch /app.war'
ENTRYPOINT ["java", \
            "-Dspring.datasource.url=jdbc:postgresql://db:5432/easyrent", \
            "-Dspring.datasource.username=easyrent", \
            "-Dspring.datasource.password=easyrent", \
            "-Deasyrent.http.host=er.gonpertek.com", \
            "-Deasyrent.http.port=80", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-jar", "/app.war"]