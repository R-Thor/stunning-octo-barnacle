# Studio Architecture  
A fully isolated, reproducible, multi‑container development environment  
(Windows 11 Native, Podman‑only)

The **Studio Architecture** is a layered, deterministic development system designed to eliminate host pollution, enforce strict isolation, and provide reproducible development workflows across multiple languages and AI workloads. This document provides the full architectural description of the Windows‑native, Podman‑only system.

---

# 1. Goals of the Architecture

The Studio Architecture is designed to:

- Provide complete isolation between projects  
- Ensure deterministic, reproducible builds  
- Support multiple Dev Containers under a single inner Podman engine  
- Provide a dedicated AI Sandbox for model experimentation  
- Maintain zero host contamination  
- Enable clean, predictable workflows for Java, .NET, and AI projects  
- Support AI‑first documentation and tooling  

This architecture is intentionally minimal, explicit, and predictable.

---

# 2. High‑Level Architecture

The system is built on a layered container model:

    Windows 11
      └── Podman Desktop (host container engine)
            └── dev-box-vscode (Canonical Workstation)
                  └── Podman (inner)
                        ├── ai-sandbox-dev (Dev Container)
                        │     └── [Model Containers]
                        │           ├── ollama
                        │           ├── lmstudio
                        │           └── openai-compatible servers
                        ├── java-dev (Dev Container)
                        └── dotnet-dev (Dev Container)

### Key Properties

- **dev‑box‑vscode** is the developer workstation  
- **Inner Podman** is the single container engine for all Dev Containers  
- **AI Sandbox** is a Dev Container, not a Podman host  
- **Model containers** run under inner Podman and are logically grouped under AI Sandbox  
- **Project Dev Containers** are siblings, not nested  
- **VS Code** connects to dev‑box‑vscode via SSH or browser  

---

# 3. Layer‑by‑Layer Breakdown

## 3.1 Windows 11 (Host)
The physical host.  
Runs Podman Desktop and provides the base environment.  
No development tooling is installed directly on Windows.

Host contains only:

- Podman Desktop  
- Visual Studio (Windows‑native workloads)  
- IIS (Windows‑native workloads)  
- Windows SDKs (if required)  

No runtimes, compilers, or SDKs for Linux‑based development.

---

## 3.2 Podman Desktop (Host Container Engine)
Podman Desktop provides:

- The container engine for dev‑box‑vscode  
- Image management  
- Volume management  
- Networking  

No project containers run directly under Podman Desktop.  
Only **dev‑box‑vscode** runs here.

---

## 3.3 dev‑box‑vscode (Canonical Workstation)
A long‑lived Fedora‑based container that provides:

- VS Code Server  
- Git  
- Shell environment  
- Inner Podman  
- Shared volumes for project folders  
- Developer tools that are not project‑specific  

This is where the developer “lives.”

VS Code connects to dev‑box‑vscode via:

- Remote SSH  
- Browser‑based VS Code Server  

---

## 3.4 Podman (inner)
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

Inner Podman is the heart of the Studio Architecture.

---

## 3.5 Dev Containers (Project Environments)

### java-dev
Contains:

- JDK  
- Maven/Gradle  
- Java debugging tools  
- Project‑specific dependencies  

### dotnet-dev
Contains:

- .NET SDK  
- NuGet tooling  
- Project‑specific dependencies  

Each Dev Container is:

- Fully isolated  
- Rebuildable  
- Declarative  
- Disposable  

---

## 3.6 AI Sandbox Dev Container

### Purpose
A dedicated environment for:

- Running local model servers  
- Experimenting with agent frameworks  
- Building AI‑driven tools  
- Keeping AI workloads isolated from project Dev Containers  

### Model Containers
Run under inner Podman:

- Ollama  
- LM Studio  
- OpenAI‑compatible servers  

These containers are:

- Siblings to project Dev Containers  
- Logically grouped under AI Sandbox  
- Not nested Podman hosts  
- Not directly accessible to java‑dev or dotnet‑dev unless explicitly exposed  

---

# 4. Networking Model

All Dev Containers and model containers share the same inner Podman network namespace.

This ensures:

- Predictable container‑to‑container communication  
- Stable port mappings  
- No cross‑layer networking surprises  

The AI Sandbox exposes model servers on known ports.  
Project Dev Containers may consume them if configured.

---

# 5. Storage Model

### dev‑box‑vscode volumes
- Persistent home directory  
- Persistent workspace directories  
- Shared access to project folders  

### Dev Container volumes
Each Dev Container may define:

- Project‑specific caches  
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

1. Start Windows  
2. Launch Podman Desktop  
3. Start dev‑box‑vscode  
4. Connect via VS Code  
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

- No Podman‑in‑Podman‑in‑Podman  
- No hidden side effects  
- No implicit networking  

## 7.4 AI‑First Documentation
All documentation is written so AI assistants can:

- Parse it  
- Reason over it  
- Maintain it  
- Extend it  

---

# 8. Future Extensions

Potential enhancements:

- Additional language Dev Containers  
- GPU‑enabled model containers  
- Distributed model serving  
- Multi‑project orchestration  
- Automated environment bootstrap scripts  
- CI/CD integration  

All extensions must preserve the core principles:

- Isolation  
- Reproducibility  
- Predictability  

---

# 9. Summary

The Studio Architecture is a clean, deterministic, multi‑container development system designed for long‑term maintainability and AI‑assisted workflows. It provides:

- A stable architecture  
- Clear separation of concerns  
- Predictable Dev Container behavior  
- A dedicated AI Sandbox  
- Zero host pollution  

This document serves as the authoritative reference for the Studio Architecture.
