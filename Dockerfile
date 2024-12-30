FROM alpine:latest
#Add a goproxy
ENV GOPROXY "https://goproxy.cn"
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
#Install Tailscale and requirements
RUN apk add curl iptables

#Install GO and Tailscale DERPER
RUN curl -fsSL "https://dl.google.com/go/go1.23.4.linux-amd64.tar.gz" -o go.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz \
    && rm go.tar.gz
ENV PATH="/usr/local/go/bin:$PATH"
RUN go install tailscale.com/cmd/derper@latest
#Debug
RUN go install tailscale.com/cmd/derpprobe@latest

#Install Tailscale and Tailscaled
RUN apk add tailscale

#Copy init script
COPY init.sh /init.sh
RUN chmod +x /init.sh

#Derper Web Ports
EXPOSE 20444/tcp
#STUN
EXPOSE 23478/udp

ENTRYPOINT /init.sh
