# r10k-webhook

Build scripts for a docker image which is composed from [puppet/r10k](https://hub.docker.com/r/puppet/r10k) and [almir/webhook](https://hub.docker.com/r/almir/webhook/).

This is meant to be run as a sidecar to a Puppetserver.

## Configuration

The following environment variables are supported:

- `GITLAB_TOKEN`

Set the "Secret Token" you've configured in Gitlab for the webhook pointing to this container.