# Dev‑Box Architecture (Containerized Development Environment on Podman)

## Purpose
Define the architecture of the dev‑box environment that runs inside the Podman host layer. This document describes the components, boundaries, and operational model of the containerized development workspace. It is an evergreen architectural reference, not an implementation log.

---

## 1. High‑Level Overview
Dev‑box is a reproducible, containerized development environment built on top of the Podman host layer. It uses OCI containers, devcontainers, and VS Code (or compatible tooling) to provide an isolated, deterministic workspace that is independent of the Windows host system.

Dev‑box does not run directly on Windows. It runs **inside the Podman Machine VM**, which provides the Linux kernel and container runtime.

---

## 2. Layered Architecture

Dev‑box sits above the Podman host layer. The full stack is:

1. **Windows 11 Pro + Hyper‑V**  
   Virtualization and networking.

2. **Podman CLI (Windows)**  
   User interface and Docker‑compatible API.

3. **Podman Machine (Fedora CoreOS)**  
   Linux kernel, container runtime, storage, networking.

4. **Dev‑Box (this layer)**  
   Containerized development environment, tools, and workspace.

Dev‑box depends on the Podman host layer but is architecturally separate from it.

---

## 3. Dev‑Box Components

### 3.1 Devcontainer Specification
Dev‑box is defined by a `devcontainer.json` file that specifies:
- Base image
- Toolchain
- Extensions
- Workspace mounts
- Environment variables
- Initialization scripts
- User identity (rootless recommended)

This file is the canonical definition of the development environment.

---

### 3.2 Base Image
The dev‑box environment is built from a Linux base image, typically:
- Debian
- Ubuntu
- Fedora
- Alpine
- Custom internal images

The base image provides:
- Shell
- Package manager
- Core utilities
- Language runtimes (if included)

---

### 3.3 Tooling Layer
Installed inside the dev‑box container:
- Programming languages (Python, Node, Go, etc.)
- Build tools (make, gcc, clang, etc.)
- Package managers
- Linting and formatting tools
- Project‑specific dependencies

This layer is fully isolated from the host.

---

### 3.4 VS Code Integration
VS Code connects to the dev‑box container using:
- The Docker‑compatible API exposed by Podman
- The devcontainer extension

Responsibilities:
- Provide editor UI
- Install extensions inside the container
- Forward ports
- Sync workspace files

VS Code runs on Windows; the development environment runs inside the container.

---

### 3.5 Workspace Mounts
Dev‑box mounts the project directory from Windows into the container using:
- Podman bind mounts
- VS Code volume mounts (optional)

This allows:
- Editing on Windows
- Execution inside Linux
- Deterministic behavior across machines

---

## 4. Execution Model

### 4.1 Container Lifecycle
Dev‑box containers are:
- Created from the devcontainer specification
- Started on demand
- Rebuilt when dependencies change
- Destroyed without affecting the host

The environment is disposable and reproducible.

---

### 4.2 User Identity
Dev‑box runs as a non‑root user inside the container unless explicitly configured otherwise. This aligns with:
- Podman rootless mode
- Best practices for development environments
- Security boundaries

---

### 4.3 Networking
Dev‑box networking flows through:
1. Container →  
2. Podman Machine VM →  
3. Hyper‑V Default Switch →  
4. Windows host →  
5. External network

Port forwarding is handled by Podman and exposed to Windows.

---

### 4.4 Storage
Dev‑box uses:
- Container filesystem for tools and dependencies
- Bind mounts for project files
- Podman Machine storage for images and layers

All state is isolated from Windows.

---

## 5. Boundaries and Responsibilities

### 5.1 What Dev‑Box *is*
- A reproducible development environment
- A containerized workspace
- A toolchain and runtime layer
- A project‑specific execution context

### 5.2 What Dev‑Box *is not*
- A virtualization layer (that is Podman + Hyper‑V)
- A Linux kernel (provided by Podman Machine)
- A Windows toolchain
- A system‑wide environment

Dev‑box is intentionally isolated from the host.

---

## 6. Failure Domains

### 6.1 Devcontainer Failures
- Invalid configuration
- Missing base image
- Build errors
- Extension installation failures

### 6.2 Podman Host Failures
- VM not running
- API pipe unavailable
- Networking issues
- Storage exhaustion

### 6.3 VS Code Failures
- Extension issues
- Connection failures
- Workspace mount problems

Each failure domain is isolated and diagnosable.

---

## 7. Reset and Recovery

### 7.1 Rebuild Dev‑Box
devcontainer rebuild  
or  
podman build (if using custom Dockerfile)

### 7.2 Remove Dev‑Box Container
podman rm -f <container>

### 7.3 Reset Dev‑Box Image
podman rmi <image>

### 7.4 Reset Podman Host (if required)
podman machine stop  
podman machine rm  
podman machine init  
podman machine start

---

## 8. Summary
Dev‑box is a containerized development environment that runs inside the Podman Machine VM. It provides a deterministic, isolated workspace that is independent of the Windows host system. Dev‑box relies on the Podman host layer for virtualization, networking, and container execution, but maintains its own toolchain, configuration, and runtime environment.

This architecture ensures reproducibility, isolation, and long‑term maintainability for development workflows.
