FROM ruby:3.1

# Install graphviz and PlantUML
RUN apt-get update -y 
RUN apt-get install -y wget default-jre default-jdk graphviz
RUN wget https://github.com/plantuml/plantuml/releases/download/v1.2022.13/plantuml-1.2022.13.jar -O plantuml.jar
RUN echo "#!/bin/bash" > plantuml ; echo "java -jar $PWD/plantuml.jar \"\$1\" \"\$2\"" >> plantuml
RUN mv plantuml /usr/bin/plantuml
RUN chmod +x /usr/bin/plantuml 

# Install Ruby project dependencies (Jekyll and plugins)
WORKDIR /usr/src/app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

# Copy project files
COPY . .

EXPOSE 4000
EXPOSE 35729
ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
