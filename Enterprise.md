# Enterprise Architecture  
A fully isolated, reproducible, multi‑container development environment

The **Enterprise** environment is a layered, deterministic development system designed to eliminate host pollution, enforce strict isolation, and provide reproducible development workflows across multiple languages and AI workloads. This document provides the full architectural description of the system.

---

# 1. Goals of the Architecture

The Enterprise environment is designed to:

- Provide **complete isolation** between projects  
- Ensure **deterministic, reproducible builds**  
- Support **multiple Dev Containers** under a single inner Podman engine  
- Provide a dedicated **AI Sandbox** for model experimentation  
- Maintain **zero host contamination**  
- Enable **clean, predictable workflows** for Java, .NET, and AI projects  
- Support **AI-first documentation and tooling**  

This architecture is intentionally minimal, explicit, and predictable.

---

# 2. High-Level Architecture

The system is built on a layered container model:

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

### Key Properties

- **dev-box** is the developer workstation  
- **Inner Podman** is the single container engine for all Dev Containers  
- **AI Sandbox** is a Dev Container, not a Podman host  
- **Model containers** run under inner Podman and are logically grouped under AI Sandbox  
- **Project Dev Containers** are siblings, not nested  
- **VS Code** is launched from inside dev-box  

---

# 3. Layer-by-Layer Breakdown

## 3.1 Windows 11
The physical host.  
Runs WSL2 and provides the base environment.  
No development tooling is installed directly on Windows.

## 3.2 WSL2: Debian-Enterprise
A hardened, minimal Linux environment.  
Provides:

- Podman (host)  
- Storage for dev-box  
- Networking for inner Podman  

WSL2 is treated as a thin substrate — not a development environment.

## 3.3 Podman (host)
Runs the **dev-box** container.  
This is the only long-lived container at this layer.

No project containers run here.

## 3.4 dev-box
The developer workstation.  
Provides:

- Shell  
- Git  
- VS Code (launched via CLI)  
- Access to inner Podman  
- Shared volumes for project folders  

This is where the developer “lives.”

## 3.5 Podman (inner)
The single container engine for:

- AI Sandbox Dev Container  
- Java Dev Container  
- .NET Dev Container  
- All model containers  

This ensures:

- Consistent networking  
- Consistent volume mounts  
- Predictable container relationships  
- Zero duplication of container engines  

## 3.6 Dev Containers (Project Environments)

### java-dev
Contains:

- JDK  
- Maven/Gradle  
- Java debugging tools  
- Project-specific dependencies  

### dotnet-dev
Contains:

- .NET SDK  
- NuGet tooling  
- Project-specific dependencies  

Each Dev Container is:

- Fully isolated  
- Rebuildable  
- Declarative  
- Disposable  

## 3.7 AI Sandbox Dev Container

### Purpose
A dedicated environment for:

- Running local model servers  
- Experimenting with agent frameworks  
- Building AI-driven tools  
- Keeping AI workloads isolated from project Dev Containers  

### Model Containers
Run under inner Podman:

- Ollama  
- LM Studio  
- OpenAI-compatible servers  

These containers are:

- Siblings to project Dev Containers  
- Logically grouped under AI Sandbox  
- Not nested Podman hosts  
- Not directly accessible to java-dev or dotnet-dev unless explicitly exposed  

---

# 4. Networking Model

All Dev Containers and model containers share the same inner Podman network namespace.

This ensures:

- Predictable container-to-container communication  
- Stable port mappings  
- No cross-layer networking surprises  

The AI Sandbox exposes model servers on known ports.  
Project Dev Containers may consume them if configured to do so.

---

# 5. Storage Model

### dev-box volumes
- Persistent home directory  
- Persistent workspace directories  
- Shared access to project folders  

### Dev Container volumes
Each Dev Container may define:

- Project-specific caches  
- Build artifacts  
- Tooling caches  

### Model container volumes
Used for:

- Model weights  
- Embeddings  
- Indexes  

All volumes are explicitly defined and isolated.

---

# 6. Development Workflow

## 6.1 Startup

1. Start WSL2  
2. Start dev-box via Podman (host)  
3. Enter dev-box  
4. Launch VS Code from inside dev-box  
5. VS Code detects `.devcontainer` folders  
6. Developer chooses which project to open  

## 6.2 Working on a project

- Open project folder in VS Code  
- VS Code attaches to the appropriate Dev Container  
- All tooling runs inside the container  
- Builds are deterministic and isolated  

## 6.3 Working with AI Sandbox

- Open the AI Sandbox folder  
- VS Code attaches to ai-sandbox-dev  
- Model containers can be started/stopped via scripts or tasks  
- AI workloads remain isolated from project Dev Containers  

---

# 7. Design Philosophy

## 7.1 Isolation
Every project runs in its own Dev Container.  
No shared dependencies.  
No host contamination.

## 7.2 Reproducibility
Every environment is:

- Declarative  
- Deterministic  
- Rebuildable  

## 7.3 Predictability
The system avoids unnecessary complexity:

- No Podman-in-Podman-in-Podman  
- No hidden side effects  
- No implicit networking  

## 7.4 AI-First Documentation
All documentation is written so AI assistants can:

- Parse it  
- Reason over it  
- Maintain it  
- Extend it  

---

# 8. Future Extensions

Potential enhancements:

- Additional language Dev Containers  
- GPU-enabled model containers  
- Distributed model serving  
- Multi-project orchestration  
- Automated environment bootstrap scripts  
- CI/CD integration  

All extensions must preserve the core principles:

- Isolation  
- Reproducibility  
- Predictability  

---

# 9. Summary

The Enterprise environment is a clean, deterministic, multi-container development system designed for long-term maintainability and AI-assisted workflows. It provides:

- A stable architecture  
- Clear separation of concerns  
- Predictable Dev Container behavior  
- A dedicated AI Sandbox  
- Zero host pollution  

This document serves as the authoritative reference for the system’s architecture.
