# PrivacyIDEA

Build a Docker image for privacyIDEA
using Github Actions & Kaniko to push to `ghcr.io`

### Variables:
* `PRIVACYIDEA_VERSION=3.8.1`
* `PYTHON_VERSION=3.10.12`

### Docker 
* build a Docker image 
* push to ~~Gitlab~~ `ghcr.io` registry

### Kubernetes
* Helm Chart development move to another 
  repository `github.com/belfhi/privacvyidea-k8s`, 
* Use this image in Kubernetes with the Helm Chart
