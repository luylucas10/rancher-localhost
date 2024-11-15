# Rancher DevOps | CI/CD | localhost

This repository contains scripts and instructions to set up a complete DevOps environment using Rancher, Kubernetes, and various CI/CD tools.

## Repository Structure

- `01-ubuntu-update.sh`: Script to prepare Ubuntu VMs for RKE2 installation by disabling the firewall, updating the system, and installing NFS.
- `02-create-main-server.sh`: Script to create the main server, install RKE2, and configure kubectl.
- `02.1-create-other-server.sh`: Optional script to create additional servers and configure RKE2.
- `02.2-create-agents.sh`: Script to configure agent nodes with RKE2.
- `03-cert-manager-digital-ocean.sh`: Script to install cert-manager and create a certificate issuer using Digital Ocean DNS01 challenge.
- `04-install-rancher.sh`: Script to install Rancher and configure ingress with cert-manager.
- `05-install-tools.sh`: Instructions to install additional tools like Longhorn, Prometheus, and Grafana.
- `06-harbor-install.sh`: Script to install Harbor, a container registry.
- `07-gitlab-install.sh`: Script to install GitLab on the Kubernetes cluster.
- `08-argocd-install.sh`: Script to install ArgoCD, a CD tool.
- `09-tekton-install.sh`: Script to install Tekton, a CI tool.
- `10-sonarqube.sh`: Script to install SonarQube, a code analysis tool.
- `11-install-elastic-search.sh`: Script to install ElasticSearch.
- `12-keycloak.sh`: Script to install Keycloak, an identity and access management tool.

## Tutorials

For more details on setting up the environment, refer to the tutorials published on Medium:

- [First Part](https://medium.com/@luylucas10/rancher-for-devs-83854a6f08e7)
- [Second Part](https://medium.com/@luylucas10/rancher-for-devs-part-2-0f9fe4596eaa)
- [Third Part]()

## How to Use

1. Prepare the Ubuntu VMs (at least three) using the `01-ubuntu-update.sh` script.
2. Create the main server with `02-create-main-server.sh`.
3. (Optional) Create additional servers with `02.1-create-other-server.sh`.
4. Configure the agent nodes with `02.2-create-agents.sh`.
5. Install cert-manager with `03-cert-manager-digital-ocean.sh`.
6. Install Rancher with `04-install-rancher.sh`.
7. Install additional tools as needed using the scripts `05-install-tools.sh` to `12-keycloak.sh`.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.