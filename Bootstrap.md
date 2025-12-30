# Bootstrap‑WSL.md

## Bootstrap Guide — WSL + Podman‑in‑Podman

### Purpose  
This guide describes how to install and initialize the WSL‑based development environment using Fedora WSL, Podman, and the dev‑box‑vscode container.

---

## 1. Enable Required Windows Features

Open PowerShell as Administrator and run:

    wsl --install

This enables:  
- Windows Subsystem for Linux  
- Virtual Machine Platform  
- Installs the default Ubuntu distro  
- Sets WSL2 as the default version  

Reboot when prompted.

---

## 2. Install Fedora WSL

Download the Fedora WSL package and install it:

    Add-AppxPackage .\FedoraWSL.appx

Launch Fedora from the Start Menu.

---

## 3. Initialize Fedora WSL

Inside Fedora, run:

    sudo dnf update -y  
    sudo dnf install podman -y  
    sudo loginctl enable-linger $USER

(Enable systemd if your Fedora build requires it.)

---

## 4. Clone Your Environment Repository

Inside Fedora:

    git clone <your-repo>  
    cd <your-repo>

This repo contains:  
- Containerfile for dev‑box‑vscode  
- Project templates  
- Documentation  
- Optional scripts

---

## 5. Build the dev‑box‑vscode Container

    podman build -t dev-box-vscode -f Containerfile .

This creates the canonical workstation container with:  
- Fedora base  
- VS Code Server  
- Podman (nested)  
- All runtimes  
- All tooling

---

## 6. Run dev‑box‑vscode

    podman run -it --name dev-box-vscode -p 127.0.0.1:2222:2222 localhost/dev-box-vscode

This starts:  
- VS Code Server  
- SSH server on port 2222  
- The full development environment

---

## 7. Connect VS Code Desktop (Optional)

If using VS Code Desktop on Windows:

1. Install the Remote SSH extension  
2. Add this to your SSH config:

       Host devbox  
           HostName 127.0.0.1  
           Port 2222  
           User dev

3. Connect to “devbox”

Alternatively, use the browser-based VS Code Server.

---

## 8. Create Project Containers

Inside dev‑box‑vscode:

    podman build -t project-<name> -f project/Containerfile .  
    podman run -it project-<name>

Each project container is:  
- Isolated  
- Reproducible  
- Versioned  
- Workspace-specific

---

## 9. Workflow Summary

- WSL provides the Linux kernel  
- Fedora WSL provides the base environment  
- dev‑box‑vscode is the canonical workstation  
- Project containers isolate workloads  
- Windows host remains clean

This completes the WSL bootstrap.
