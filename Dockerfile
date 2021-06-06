FROM ubuntu:focal

WORKDIR /root

RUN apt-get update && apt-get install curl jq git build-essential -y
RUN rm -rf /usr/local/go 
RUN (curl https://dl.google.com/go/go1.16.3.linux-amd64.tar.gz | tar -C/usr/local -zxvf -)

# Update environment variables to include go
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV GO111MODULE=on
ENV PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

RUN git clone https://github.com/Sifchain/sifnode.git && \
cd sifnode && \
git checkout mainnet-genesis && \
CHAINNET=mainnet make install 

COPY run.sh .

EXPOSE 1317
EXPOSE 26656
EXPOSE 26657



CMD ["sh", "./run.sh"]
