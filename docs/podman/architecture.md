# Podman Host Architecture (Windows 11 Pro + Hyper‑V)

## Purpose
Define the architecture of the Podman host layer running on Windows 11 Pro with Hyper‑V. This document describes the components, boundaries, and operational model that support containerized development environments (e.g., dev‑box). This is an evergreen architectural reference, not an implementation log.

---

## 1. High‑Level Overview
The Podman host layer provides a Linux container runtime on Windows by running a Fedora CoreOS virtual machine under Hyper‑V. The Windows Podman CLI communicates with this VM over a local SSH channel and exposes a Docker‑compatible API pipe for tooling interoperability. This layer is the foundation for higher‑level development environments such as dev‑box, but is not itself a development environment.

---

## 2. Architectural Components

### 2.1 Windows Host (Layer 0)
- Operating System: Windows 11 Pro
- Virtualization: Hyper‑V (required)
- Networking: Hyper‑V Default Switch (NAT)
- Security Boundary: Windows Firewall

Responsibilities:
- Provide virtualization platform
- Manage VM lifecycle through Hyper‑V
- Enforce host‑level security and networking rules

---

### 2.2 Podman CLI (Layer 1)
- Installed via official Windows MSI
- Provides `podman.exe` commands
- Auto‑detects Hyper‑V as the provider
- Manages Podman Machine lifecycle
- Exposes Docker‑compatible API via named pipe:
  npipe:////./pipe/docker_engine

Responsibilities:
- User‑facing command interface
- API forwarding for Docker‑based tools
- Communication with the Podman Machine VM

---

### 2.3 Podman Machine VM (Layer 2)
- OS: Fedora CoreOS (immutable, auto‑updated)
- Kernel: Linux 6.x
- Runtime: crun
- Cgroups: v2
- Networking: netavark + pasta (rootless)
- Storage: overlayfs (rootless user namespace)
- Mode: rootless (default, recommended)

Responsibilities:
- Execute containers
- Manage images and storage
- Provide Linux kernel features required by OCI runtimes

---

## 3. Execution Model

### 3.1 Rootless Mode (Default)
Podman Machine runs containers in a non‑privileged user namespace. This mode:
- Improves security
- Simplifies networking
- Avoids privileged port binding (<1024)
- Reduces host‑level attack surface
- Aligns with modern container best practices

Rootful mode is available but not recommended unless required.

---

### 3.2 Networking Model
- Hyper‑V Default Switch provides NAT connectivity
- Podman Machine uses `pasta` (or `slirp4netns`) for rootless networking
- Containers receive outbound internet access
- Port forwarding is user‑initiated via `-p` flags
- Windows Firewall prompts once during machine initialization

---

### 3.3 Storage Model
Rootless storage paths inside the VM:
- Image store: /var/home/core/.local/share/containers/storage
- Container runtime state: /run/user/1000/containers

OverlayFS is used for layered image storage.

---

## 4. Interoperability

### 4.1 Docker API Compatibility
Podman exposes a Docker‑compatible API via:
npipe:////./pipe/docker_engine

This enables:
- VS Code devcontainers
- Docker Compose v2
- Docker‑based tooling
- GitHub Actions local runners

No DOCKER_HOST configuration is required.

---

### 4.2 OCI Compatibility
Podman is fully OCI‑compliant:
- Images
- Runtimes
- Manifests
- Registries

Compatible with:
- Docker Hub
- Quay.io
- GHCR
- Any OCI registry

---

## 5. Boundaries and Responsibilities

### 5.1 What the Podman Host Layer *is*
- A Linux container runtime
- A Hyper‑V‑backed VM
- A Docker‑compatible API endpoint
- A stable foundation for dev‑box

### 5.2 What the Podman Host Layer *is not*
- A development environment
- A workspace
- A toolchain
- A devcontainer configuration

Those belong to the dev‑box layer, which runs on top of this architecture.

---

## 6. Failure Domains

### 6.1 Windows Layer Failures
- Hyper‑V disabled or corrupted
- Missing Default Switch
- Firewall blocking Podman
- Windows updates affecting virtualization

### 6.2 Podman CLI Failures
- PATH misconfiguration
- Corrupted installation
- Version drift

### 6.3 Podman Machine Failures
- VM corruption
- Storage exhaustion
- Network misconfiguration
- Rootless namespace issues

Each layer can be reset independently.

---

## 7. Reset and Recovery

### 7.1 Reset Podman Machine
podman machine stop
podman machine rm
podman machine init
podman machine start

### 7.2 Reinstall Podman CLI
Uninstall via Windows Apps → reinstall MSI.

### 7.3 Hyper‑V Recovery
- Re‑enable Hyper‑V feature
- Recreate Default Switch
- Restart VMMS service

---

## 8. Summary
The Podman host layer is a three‑tier architecture:

1. Windows 11 Pro + Hyper‑V  
   Provides virtualization and networking.

2. Podman CLI (Windows)  
   Provides user interface and API forwarding.

3. Podman Machine (Fedora CoreOS)  
   Executes containers in a secure, rootless Linux environment.

This architecture is deterministic, reproducible, and suitable as the foundation for higher‑level development environments such as dev‑box.
