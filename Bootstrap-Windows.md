Bootstrap Guide — Windows 11 + Podman‑Only

Purpose:
This guide describes how to install and initialize the Windows-native development environment using Podman and the dev‑box‑vscode container.

1. Prerequisites
- Windows 11 (latest updates)
- Administrator access

2. Install Podman Desktop
- Download Podman Desktop
- Install with default settings
- Launch Podman Desktop
- Ensure Linux containers are enabled

3. Clone Environment Repository
    git clone <your-repo>
    cd <your-repo>

4. Build dev‑box‑vscode Container
    podman build -t dev-box-vscode -f Containerfile .

5. Run dev‑box‑vscode
    podman run -it --name dev-box-vscode -p 127.0.0.1:2222:2222 localhost/dev-box-vscode

This starts VS Code Server inside the container.

6. Connect VS Code Desktop (Optional)
Use Remote SSH to connect to:
    localhost:2222

7. Create Project Containers
Inside dev‑box‑vscode:
    podman build -t project-<name> -f project/Containerfile .
    podman run -it project-<name>

8. Workflow Summary
- Host stays clean
- dev‑box‑vscode is your workstation
- Project containers isolate workloads
- Visual Studio + IIS remain on host for Windows-native tasks

