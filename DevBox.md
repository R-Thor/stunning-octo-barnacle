# dev-box  
The persistent developer workstation inside the Enterprise environment

The **dev-box** container is the central workspace for all development activity in the Enterprise architecture. It acts as the developer’s “machine” inside WSL2 and provides access to the inner Podman engine that runs all Dev Containers and model containers.

This document explains the purpose, structure, workflows, and best practices for using dev-box.

---

# 1. Purpose of dev-box

The dev-box container exists to:

- Provide a **persistent developer workstation**  
- Serve as the **entry point** for all development workflows  
- Host the **inner Podman** instance used by all Dev Containers  
- Launch VS Code in a controlled environment  
- Keep the host system (Windows + WSL2) clean and untouched  
- Provide a stable, reproducible environment for all projects  

dev-box is the only long-lived container in the system.

---

# 2. Architectural Placement

dev-box runs under **Podman (host)** inside WSL2.

    Windows 11
      └── WSL2: Debian-Enterprise
            └── Podman (host)
                  └── dev-box
                        └── Podman (inner)
                              ├── ai-sandbox-dev (Dev Container)
                              ├── java-dev (Dev Container)
                              └── dotnet-dev (Dev Container)

Key points:

- dev-box is the **only** container running directly under Podman (host)  
- All Dev Containers run under **inner Podman**, not under WSL2  
- VS Code is launched from inside dev-box  
- dev-box provides the environment where developers “live” day-to-day  

---

# 3. What dev-box Contains

The dev-box container includes:

## Core Tools
- Git  
- Shell utilities  
- Build essentials  
- Podman (inner)  
- SSH client  
- Common CLI tools  

## Developer Tools
- VS Code CLI (`code`)  
- Optional: Node.js, Python, or other utilities  
- Scripts for managing Dev Containers  
- Scripts for managing model containers  

## Environment Configuration
- Persistent home directory  
- Persistent workspace directories  
- Shared volumes for project folders  

dev-box is intentionally minimal but powerful.

---

# 4. Why dev-box Exists

dev-box solves several architectural problems:

### **4.1 Isolation**
No development tools are installed on:

- Windows  
- WSL2  

Everything happens inside dev-box.

### **4.2 Reproducibility**
Every developer uses the same:

- Shell  
- Tools  
- Podman version  
- VS Code environment  

### **4.3 Predictability**
All Dev Containers run under the same inner Podman instance, ensuring:

- Stable networking  
- Consistent volume mounts  
- Predictable container relationships  

### **4.4 Clean Host**
Windows and WSL2 remain untouched.

---

# 5. Workflow

## 5.1 Starting dev-box

1. Start WSL2  
2. Run Podman (host)  
3. Start the dev-box container  
4. Enter dev-box  
5. Launch VS Code from inside dev-box  

Example:

    podman start dev-box
    podman exec -it dev-box bash
    code .

VS Code will now detect `.devcontainer` folders and attach to the appropriate Dev Container.

---

## 5.2 Using dev-box

Inside dev-box, you can:

- Manage Dev Containers  
- Manage model containers  
- Run Podman commands  
- Launch VS Code  
- Work with Git  
- Access project folders  

dev-box is your “machine.”

---

## 5.3 Managing Dev Containers

From inside dev-box:

    podman ps
    podman images
    podman run ...
    podman stop ...
    podman logs ...

All Dev Containers (java-dev, dotnet-dev, ai-sandbox-dev) run under this inner Podman instance.

---

## 5.4 Launching VS Code

Always launch VS Code from inside dev-box:

    code .

This ensures:

- VS Code uses the correct Podman engine  
- Dev Containers attach correctly  
- Project isolation is preserved  

---

# 6. Storage Model

dev-box uses persistent volumes for:

- Home directory  
- Workspace directories  
- Podman storage  
- Configuration files  

This ensures:

- Your shell environment persists  
- Your Git configuration persists  
- Your Podman images persist  
- Your project folders persist  

Dev Containers themselves remain disposable.

---

# 7. Rebuilding dev-box

dev-box is designed to be long-lived, but you can rebuild it if needed.

Steps:

1. Stop dev-box  
2. Remove the container  
3. Rebuild using the dev-box Dockerfile/Containerfile  
4. Recreate persistent volumes  
5. Start dev-box again  

Because dev-box is declarative, rebuilding is safe and predictable.

---

# 8. Best Practices

- Always launch VS Code from inside dev-box  
- Never install development tools on Windows or WSL2  
- Keep dev-box minimal and clean  
- Use inner Podman for all Dev Containers  
- Treat dev-box as your “developer workstation”  
- Rebuild dev-box only when necessary  
- Keep scripts inside dev-box for managing containers  

---

# 9. Summary

dev-box is the heart of the Enterprise environment. It provides:

- A persistent developer workstation  
- A clean, reproducible environment  
- The inner Podman engine  
- A stable foundation for all Dev Containers  
- A clean separation between host and development layers  

This document serves as the authoritative reference for dev-box inside the Enterprise architecture.
