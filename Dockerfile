FROM alpine:latest
#Add a goproxy
ENV GOPROXY "https://goproxy.cn"
#Install Tailscale and requirements
RUN apk add curl iptables

#Install GO and Tailscale DERPER
RUN apk add go --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community
RUN go install tailscale.com/cmd/derper@main

#Install Tailscale and Tailscaled
RUN apk add tailscale --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

#Copy init script
COPY init.sh /init.sh
RUN chmod +x /init.sh

#Derper Web Ports
EXPOSE 444/tcp
#STUN
EXPOSE 3478/udp

ENTRYPOINT /init.sh
