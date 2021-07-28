# Este archivo construye un contendor desde una imagen de gradle en el Fork de la rama principal.
# Etapa de construcción.

# Usamos una imagen de gradle que monta un open jdk9.
# FROM gradle:7.1.1-jdk11
FROM openjdk:11 AS base
WORKDIR /opt/hello-gradle

# Copiar en el workdir lo de gradle
# COPY build/libs/demo-0.0.1-SNAPSHOT.jar ./
COPY ./ ./

# ENV PATH '$PATH:/var/scr/app'

# RUN no insteresará ejecutarlo cuando construyamos el contenedor o ejecutamos el contenedor.
# Ejecutamos BootRun. \ SIRBE PARA MULTILINEA Y && (CORTOCIRCUITO) CONCATENEA COMANDOS SECUENCIALMENTE Y SI HAY ALGUNO QUE RETORNA FALSO SE DETIENE ANULANDO TODA LA SECUENCIA.
RUN ./gradlew assemble \
&& rm -rf /root/.gradle

#ENTRYPOINT ["./gradlew", "bootRun"]
# CMD ./gradlew bootRun
# CMD java -jar build/libs/demo-0.0.1-SNAPSHOT.jar

# Etapa de ejecución.
FROM amazoncorretto:11
WORKDIR /opt/hello-gradle
COPY --from=base /opt/hello-gradle/build/lib/hello-spring-0.0.1-SNAPSHOT.jar ./
CMD java -jar build/libs/hello-spring-0.0.1-SNAPSHOT.jar
