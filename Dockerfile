FROM openjdk:8-jdk-alpine
VOLUME /tmp
RUN addgroup -S springG && adduser -S spring -G springG
USER spring:springG
ARG DEPENDENCY=target
ARG APP_PORT=9090
ENV APP_ENV_PORT ${APP_PORT}
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
EXPOSE $APP_PORT
ENTRYPOINT ["java","-Dserver.port=${APP_ENV_PORT}","-Djava.security.egd=file:/dev/./urandom","-cp","app:app/lib/*","org.springframework.samples.petclinic.PetClinicApplication"]
