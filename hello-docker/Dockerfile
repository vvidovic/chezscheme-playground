FROM ubuntu:20.04

RUN apt update
RUN apt install -y chezscheme
RUN useradd -U -M schemer

COPY . /app
RUN chown -R schemer:schemer ./app
WORKDIR /app

USER schemer

RUN echo '(compile-file "hello.ss")' | scheme

CMD scheme -q /app/hello.ss
