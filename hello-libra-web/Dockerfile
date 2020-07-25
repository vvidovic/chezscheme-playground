FROM ubuntu:20.04

RUN apt update
RUN apt install -y curl
RUN apt install -y chezscheme
RUN useradd -U -M schemer

COPY . /app
RUN chown -R schemer:schemer ./app
WORKDIR /app

####################
# raven installation
####################
RUN curl -L https://github.com/guenchi/Raven/archive/0.3.6.tar.gz | tar -xz
RUN mv Raven-0.3.6 raven
RUN mkdir /usr/local/lib/raven
RUN mv raven /usr/local/lib/raven
RUN ln -s /usr/local/lib/raven/raven/raven.sc /usr/local/bin/raven
RUN chmod +x /usr/local/bin/raven
RUN raven install -g raven
####################

####################
# libra installation
####################
# json version 0.5.6 declared in libra/package.sc is not available, install
# the latest version.
RUN raven install json
RUN raven install libra
# Fix libra library dependency on the non-existing json lib method.
RUN sed -i 's/scm->json-string/json->string/' lib/libra/libra.sls
####################

ENV CHEZSCHEMELIBDIRS=.:lib:/usr/local/lib
ENV CHEZSCHEMELIBEXTS=.chezscheme.sls::.chezscheme.so:.ss::.so:.sls::.so:.scm::.so:.sch::.so:.sc::.so


USER schemer

#RUN echo '(compile-file "hello.ss")' | scheme

CMD scheme -q /app/app.ss
