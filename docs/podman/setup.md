Podman Setup: Fresh Windows 11 Pro → Known‑Good Baseline
Document Type: Operational Procedure
Author: A
Purpose: Establish a deterministic, reproducible Podman + Hyper‑V environment on a clean Windows 11 Pro system.
Status: Verified working
Date: 2026‑01‑02

0. Starting Point
- Clean installation of Windows 11 Pro
- All Windows Updates applied
- Hyper‑V enabled and verified functional
- No prior container runtimes installed

1. Verify Hyper‑V Health
Open PowerShell (Admin) and run:

    Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
    Get-Service vmms
    Get-VMHost
    Get-VMSwitch

Expected:
- Hyper‑V feature: Enabled
- vmms service: Running
- Get-VMHost returns host info
- Get-VMSwitch includes “Default Switch”

This confirms Hyper‑V is healthy and ready for Podman.

2. Install Podman CLI (MSI Installer)
Download and run the official Podman for Windows MSI installer.

Verify installation:

    podman --version

Expected:
- Version: 5.x.x
- OS: windows/amd64

This confirms the CLI is installed correctly and PATH is configured.

3. Initialize Podman Machine (Hyper‑V Auto‑Detected)

    podman machine init

Expected behavior:
- Podman downloads Fedora CoreOS image
- Extracts VHDX
- Creates Hyper‑V VM: podman-machine-default
- Windows Firewall prompts to allow podman.exe

Firewall note:
During `podman machine init`, Windows will prompt to allow `podman.exe` through
the firewall. This is expected. Podman uses a local SSH channel and a NAT
network created by Hyper‑V, and Windows Firewall requires explicit approval for
the new network endpoint. Select “Allow” to enable Podman Machine networking.

Machine init completes with:
“Machine init complete”

4. Start the Podman Machine

    podman machine start

Expected output:
- “Machine started successfully”
- Rootless mode notice (expected)
- Docker API forwarding active: npipe:////./pipe/docker_engine

This confirms:
- Hyper‑V VM booted
- SSH connectivity established
- Docker‑compatibility pipe active

5. Verify Podman Machine Health

    podman info

Expected key signals:

Client (Windows):
- APIVersion: 5.x.x
- Os: windows
- OsArch: windows/amd64

Host (Hyper‑V VM):
- distribution: fedora coreos 43
- kernel: 6.x
- cgroupVersion: v2
- ociRuntime: crun
- networkBackend: netavark
- rootless: true
- remoteSocket exists
- storage driver: overlay

Machine resources:
- cpus: 6
- memTotal: ~2GB

This confirms the VM is healthy and fully operational.

6. Run Hello‑World Test Container

    podman run --rm hello-world

Expected:
- Image pulls successfully
- Container runs and prints “Hello Podman World”
- Container auto‑removes (--rm)

This validates:
- Registry access
- Networking
- Storage
- Runtime
- VM connectivity
- Rootless execution

7. Confirm Image and Container State

    podman image ls
    podman container ls

Expected:
- hello-world image present
- No running containers (because --rm was used)

8. Final Baseline Status
At this point, the system is in a known‑good, reproducible state:

- Windows 11 Pro clean install
- Hyper‑V fully functional
- Podman CLI 5.x installed correctly
- Podman Machine running Fedora CoreOS 43
- Rootless mode active (correct default)
- Docker API compatibility enabled
- Networking stable
- Image pulling works
- Containers run successfully
- No drift, no leftover configs

This is the canonical baseline for all future dev‑box and container workflows.
