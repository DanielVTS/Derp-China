#!/usr/bin/env sh

#Start tailscaled and connect to tailnet(just need derper)
#/usr/sbin/tailscaled --state=/var/lib/tailscale/tailscaled.state &> /var/lib/tailscale/tailscaled_initial.log &
#/usr/bin/tailscale up --accept-routes=true --accept-dns=true --auth-key $TAILSCALE_AUTH_KEY &> /var/lib/tailscale/tailscale_onboard.log &

#Start Tailscale derp server
/root/go/bin/derper --hostname=$TAILSCALE_DERP_HOSTNAME --a=$TAILSCALE_DERP_ADDR --stun-port=$TAILSCALE_DERP_STUN_PORT --verify-clients=$TAILSCALE_DERP_VERIFY_CLIENTS
