# plantuml image
FROM ubuntu AS plantuml

RUN apt-get update -y 
RUN apt-get install -y wget default-jre default-jdk graphviz
RUN wget https://github.com/plantuml/plantuml/releases/download/v1.2022.13/plantuml-1.2022.13.jar -O plantuml.jar
RUN echo "#!/bin/bash" > plantuml ; echo "java -jar $PWD/plantuml.jar \"\$1\" \"\$2\"" >> plantuml
RUN mv plantuml /usr/bin/plantuml
RUN chmod +x /usr/bin/plantuml

# main image
FROM rust:slim-buster

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    libssl-dev pkg-config
RUN cargo install mdbook
RUN cargo install mdbook-plantuml

COPY --from=plantuml /usr/bin/plantuml /usr/bin/plantuml

EXPOSE 3000
WORKDIR /usr/src/app

# Copy project files
COPY . .

ENTRYPOINT ["mdbook"]
