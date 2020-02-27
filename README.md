# r10k-webhook

Build scripts for a docker image which is composed from [puppet/r10k](https://hub.docker.com/r/puppet/r10k) and [almir/webhook](https://hub.docker.com/r/almir/webhook/).

This is meant to be run as a sidecar of a Puppetserver exposing r10k over HTTP. Be carefull: There is currently not authentication!

## Configuration

To make this work, you have to mount your r10k.yaml configuration to /etc/puppetlabs/r10k/r10k.yaml.

The following environment variables are supported:

- `DEPLOY_CONTROL_ON_START`

Set this to `true` if you want r10k to deployment your control repository on container startup.
