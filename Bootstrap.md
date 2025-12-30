# Bootstrap Guide  
Initialize and launch the Enterprise development environment

This document provides the complete, step‑by‑step bootstrap process for setting up the Enterprise architecture from a clean Windows 11 system. It covers WSL2 initialization, Podman setup, dev-box creation, and the workflow for launching VS Code and Dev Containers.

This is the authoritative guide for bringing the system online.

---

# 1. Overview

The bootstrap process creates the following stack:

    Windows 11
      └── WSL2: Debian-Enterprise
            └── Podman (host)
                  └── dev-box
                        └── Podman (inner)
                              ├── ai-sandbox-dev (Dev Container)
                              ├── java-dev (Dev Container)
                              └── dotnet-dev (Dev Container)

The goal is to:

- Keep Windows clean  
- Keep WSL2 clean  
- Run all development inside dev-box  
- Run all Dev Containers under inner Podman  
- Ensure deterministic, reproducible environments  

---

# 2. Prerequisites

Before bootstrapping, ensure:

- Windows 11 is fully updated  
- WSL2 is enabled  
- Virtualization is enabled in BIOS  
- You have administrative rights  

No development tools should be installed on Windows.

---

# 3. Install WSL2

Open PowerShell (Admin):

    wsl --install

Reboot when prompted.

After reboot:

    wsl --set-default-version 2

Install Debian:

    wsl --install -d Debian

This becomes **Debian-Enterprise**.

---

# 4. Configure Debian-Enterprise

Inside Debian:

Update packages:

    sudo apt update && sudo apt upgrade -y

Install dependencies:

    sudo apt install -y \
        curl \
        git \
        unzip \
        ca-certificates \
        gnupg \
        build-essential

---

# 5. Install Podman (host)

Inside Debian:

    sudo apt install -y podman

Verify:

    podman --version

Enable user-mode Podman:

    podman info

If needed, initialize storage:

    podman machine init
    podman machine start

---

# 6. Create dev-box

Clone your Enterprise repo inside Debian:

    git clone <your-repo-url>
    cd <repo>

Build dev-box:

    podman build -t dev-box -f dev-box/Containerfile .

Create persistent volumes:

    podman volume create devbox-home
    podman volume create devbox-workspace

Run dev-box:

    podman run -d \
      --name dev-box \
      -v devbox-home:/home/dev \
      -v devbox-workspace:/workspace \
      --privileged \
      dev-box

Enter dev-box:

    podman exec -it dev-box bash

You now “live” inside dev-box.

---

# 7. Initialize Inner Podman

Inside dev-box:

Verify Podman is installed:

    podman --version

Initialize storage:

    podman info

This Podman instance is the **inner Podman** that will run all Dev Containers.

---

# 8. Launch VS Code

Inside dev-box:

    code .

VS Code will:

- Connect to dev-box  
- Detect `.devcontainer` folders  
- Offer to reopen in the appropriate Dev Container  

This is the correct workflow.

---

# 9. Build Dev Containers

Open each project folder in VS Code:

- `ai-sandbox/`
- `java-project/`
- `dotnet-project/`

VS Code will automatically:

- Detect `.devcontainer/devcontainer.json`  
- Build the Dev Container  
- Attach to it  

Each Dev Container runs under **inner Podman**.

---

# 10. Start Model Containers (Optional)

Inside the AI Sandbox Dev Container:

    ./start-ollama.sh
    ./start-lmstudio.sh
    ./start-openai-server.sh

Or use Podman directly:

    podman run ...
    podman ps

Model containers run under inner Podman and are logically grouped under AI Sandbox.

---

# 11. Recommended Daily Workflow

1. Start WSL2  
2. Start dev-box  
3. Enter dev-box  
4. Launch VS Code from inside dev-box  
5. Open a project folder  
6. VS Code attaches to the correct Dev Container  
7. Develop normally  

This ensures:

- Isolation  
- Reproducibility  
- Predictability  

---

# 12. Rebuilding the Environment

## Rebuild a Dev Container

Inside VS Code:

    Dev Containers: Rebuild Container

## Rebuild dev-box

    podman stop dev-box
    podman rm dev-box
    podman build -t dev-box -f dev-box/Containerfile .
    podman run ... (same as initial run)

## Rebuild inner Podman

Inside dev-box:

    rm -rf ~/.local/share/containers
    podman info

---

# 13. Troubleshooting

## VS Code cannot attach to Dev Container
- Ensure VS Code was launched **inside dev-box**  
- Ensure inner Podman is working (`podman ps`)  

## Dev Container build fails
- Rebuild dev-box  
- Rebuild the Dev Container  
- Ensure volumes are not corrupted  

## Model containers cannot start
- Ensure inner Podman is running  
- Ensure ports are not in use  
- Rebuild the model container  

---

# 14. Summary

This bootstrap guide provides the complete process for:

- Installing WSL2  
- Installing Podman  
- Creating dev-box  
- Initializing inner Podman  
- Launching VS Code  
- Building Dev Containers  
- Running model containers  

Follow this guide to bring the Enterprise environment online in a clean, deterministic, reproducible way.
