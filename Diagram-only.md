# Diagram-Only  
All architecture diagrams in one place

This document collects all diagrams used throughout the Enterprise documentation suite.  
There is no narrative — only diagrams for quick reference.

---

# 1. Full Enterprise Architecture

    Windows 11
      └── WSL2: Debian-Enterprise
            └── Podman (host)
                  └── dev-box
                        └── Podman (inner)
                              ├── ai-sandbox-dev (Dev Container)
                              │     └── [Model Containers]
                              │           ├── ollama
                              │           ├── lmstudio
                              │           └── openai-compatible servers
                              ├── java-dev (Dev Container)
                              └── dotnet-dev (Dev Container)

---

# 2. Dev Container Relationships

    dev-box
      └── Podman (inner)
            ├── ai-sandbox-dev
            ├── java-dev
            └── dotnet-dev

All Dev Containers are siblings.  
All run under the same inner Podman instance.

---

# 3. AI Sandbox + Model Containers

    ai-sandbox-dev
      └── [Model Containers]
            ├── ollama
            ├── lmstudio
            └── openai-compatible servers

Model containers are logically grouped under AI Sandbox  
but run under inner Podman.

---

# 4. Project Dev Containers

    java-dev
      ├── JDK
      ├── Maven/Gradle
      ├── Debugger
      └── VS Code integrations

    dotnet-dev
      ├── .NET SDK
      ├── ASP.NET runtime
      ├── Debugger
      └── VS Code integrations

Each project has its own isolated Dev Container.

---

# 5. dev-box Structure

    dev-box
      ├── VS Code CLI
      ├── Git
      ├── Shell utilities
      ├── Podman (inner)
      └── Workspace volumes

dev-box is the persistent developer workstation.

---

# 6. Networking Model

    [Inner Podman Network]
        ├── ai-sandbox-dev
        ├── java-dev
        ├── dotnet-dev
        ├── ollama
        ├── lmstudio
        └── openai-compatible servers

All containers share the same network namespace.

---

# 7. Storage Model

    dev-box volumes
      ├── home
      └── workspace

    Dev Container volumes
      ├── caches
      ├── build artifacts
      └── tooling data

    Model container volumes
      ├── model weights
      ├── embeddings
      └── indexes

---

# 8. Workflow Overview

    Start WSL2
      → Start dev-box
        → Enter dev-box
          → Launch VS Code
            → VS Code attaches to Dev Container
              → Develop inside isolated environment

---

# End of Diagram-Only.md
