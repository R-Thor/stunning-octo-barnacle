# Dev‑Box‑VSCode (WSL Architecture)

## Purpose
This document defines the canonical development environment architecture using WSL2 as the Linux host, Fedora as the base distribution, and Podman‑in‑Podman (PiNP) for containerized development. VS Code Server runs inside the dev‑box‑vscode container.

---

# 1. Host Architecture (Windows 11)
The Windows host provides:
- WSL2 backend
- Virtual Machine Platform
- Podman Desktop (optional)
- VS Code Desktop (optional)

The host does NOT contain:
- No Linux runtimes
- No compilers
- No SDKs
- No global tools
- No Docker Desktop

The host is intentionally minimal.

---

# 2. WSL2 Linux Distribution
The canonical Linux environment is:
- Fedora (WSL)
- Systemd enabled
- Podman installed
- No development tools installed directly

WSL acts as the “Linux hypervisor.”

---

# 3. dev‑box‑vscode Container (Canonical Workstation)
Inside Fedora WSL, the dev‑box‑vscode container provides:
- Fedora base image
- VS Code Server
- Podman (nested)
- All runtimes (Node, Python, Go, Rust, etc.)
- All language servers
- All extensions
- All tooling

This container is the workstation.

---

# 4. Podman‑in‑Podman (PiNP)
Nested Podman allows:
- Project containers inside dev‑box‑vscode
- Full isolation
- Reproducible builds
- No host pollution
- No WSL pollution

---

# 5. Project Containers
Each project has:
- Its own Containerfile
- Its own VS Code workspace
- Its own dependencies
- Its own runtime versions
- Zero cross‑contamination

---

# 6. Philosophy
- WSL is the Linux kernel provider
- dev‑box‑vscode is the workstation
- Project containers isolate workloads
- Host remains clean
