# AI Collaboration Guide — WSL Architecture

## Purpose
This document explains how AI assistants should reason about the WSL‑based development environment.

---

# 1. Host Interpretation
The Windows host is minimal and only provides:
- WSL2
- Podman Desktop (optional)
- VS Code Desktop (optional)

AI should not assume:
- Docker Desktop exists
- Windows contains runtimes
- Windows contains compilers

---

# 2. WSL Interpretation
WSL is:
- The Linux kernel provider
- The environment where Podman runs
- The environment where dev‑box‑vscode is launched

AI should assume:
- All Linux development happens inside containers
- WSL itself remains clean

---

# 3. dev‑box‑vscode Interpretation
The dev‑box‑vscode container is:
- The canonical workstation
- The location of all runtimes
- The location of all tooling
- The location of VS Code Server
- The environment for nested Podman

---

# 4. Project Isolation
Each project has its own container(s).  
AI should:
- Treat each project as isolated
- Avoid cross‑project assumptions

---

# 5. Philosophy
- WSL is the kernel
- dev‑box‑vscode is the workstation
- Project containers isolate workloads
