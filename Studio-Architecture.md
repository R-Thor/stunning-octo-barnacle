# Studio Architecture  
A Windows‑native, Podman‑based, fully isolated development platform

The **Studio Architecture** is an abstract, container‑orchestrated development environment designed to host **any** Dev Container: labs, proofs of concept, sandboxes, experiments, training environments, or full project workspaces. It provides a deterministic, reproducible, and isolated platform for engineering work without polluting the host system.

This document describes the architecture, its layers, its components, and the patterns used to host arbitrary Dev Containers.

---

# 1. Purpose of the Studio

The Studio is designed to:

- Provide a **clean, isolated, reproducible** development environment  
- Support **arbitrary Dev Containers** (not tied to any specific language or project)  
- Offer a **persistent workstation container** for consistent tooling  
- Run all workloads under a **single inner Podman engine**  
- Support optional **AI workloads** through a dedicated AI Sandbox  
- Maintain **zero host pollution**  
- Enable **deterministic rebuilds** and **predictable workflows**  
- Serve as a **general-purpose platform** for experimentation, training, and development  

The Studio is not a Java environment, a .NET environment, or an AI environment.  
It is a **platform** that can host any of those.

---

# 2. Architectural Layers

The Studio is built on a clean, layered model:

```
Windows 11
  └── Podman Desktop (outer Podman)
        └── dev-box-vscode (persistent workstation container)
              └── Podman (inner Podman)
                    ├── [Arbitrary Dev Containers]
                    │     ├── labs
                    │     ├── POCs
                    │     ├── sandboxes
                    │     ├── experiments
                    │     ├── training environments
                    │     └── project workspaces
                    └── ai-sandbox-dev (optional)
                          └── [Model Containers]
                                ├── ollama
                                ├── lmstudio
                                └── openai-compatible servers
```

Each layer has a specific purpose and strict boundaries.

---

# 3. Layer Descriptions

## 3.1 Windows 11 (Host Layer)
The physical host system.  
No development tooling is installed directly on Windows except:

- Podman Desktop  
- VS Code (optional)  

All development happens inside containers.

---

## 3.2 Podman Desktop (Outer Podman)
The container engine running on Windows.  
Its responsibilities:

- Run the **dev‑box‑vscode** workstation container  
- Provide a clean, minimal interface to container management  
- Avoid running project containers directly on the host  

No Dev Containers run here.

---

## 3.3 dev‑box‑vscode (Canonical Workstation)
A persistent Fedora‑based container that acts as the developer’s workstation.

It provides:

- A stable Linux environment  
- A consistent toolchain  
- A single place for VS Code to connect  
- A controlled environment for running the inner Podman engine  

VS Code connects via:

- Remote SSH  
- Browser (code-server)  
- VS Code Remote Containers  

This container is long‑lived and acts as the “desktop” inside the Studio.

---

## 3.4 Inner Podman (Primary Runtime)
The inner Podman engine is the heart of the Studio.

It runs:

- Arbitrary Dev Containers  
- Optional AI Sandbox  
- Optional model containers  

This ensures:

- All workloads share the same runtime  
- All workloads are isolated from the host  
- All Dev Containers follow the same pattern  
- Reproducibility across projects  

---

## 3.5 Arbitrary Dev Containers
The Studio supports **any number** of Dev Containers, including:

- Labs  
- Proofs of concept  
- Sandboxes  
- Experiments  
- Training environments  
- Full project workspaces  

Each Dev Container is:

- Isolated  
- Reproducible  
- Declarative  
- Disposable  
- Self‑contained  

Examples (not required):

- `java-dev`  
- `dotnet-dev`  
- `python-dev`  
- `rust-dev`  
- `go-dev`  

These are **examples only**, not fixed components of the architecture.

---

## 3.6 AI Sandbox (Optional)
A specialized Dev Container for AI experimentation.

It may host:

- Local model servers  
- Agent frameworks  
- Vector databases  
- Embedding pipelines  
- OpenAI‑compatible APIs  

Model containers run **inside** the AI Sandbox, not directly under inner Podman.

Examples:

- Ollama  
- LM Studio  
- OpenAI‑compatible servers  

This keeps AI workloads isolated from project environments.

---

# 4. Architectural Principles

## 4.1 Isolation
Each Dev Container is fully isolated:

- No shared dependencies  
- No cross‑contamination  
- No host pollution  

## 4.2 Reproducibility
Every environment is:

- Declarative  
- Deterministic  
- Rebuildable  

## 4.3 Predictability
The architecture avoids unnecessary complexity:

- No Podman‑in‑Podman‑in‑Podman  
- No hidden networking  
- No implicit side effects  

## 4.4 Extensibility
The Studio can host:

- Any language  
- Any framework  
- Any tooling  
- Any number of Dev Containers  

## 4.5 AI‑First Documentation
All documentation is structured for:

- AI reasoning  
- AI maintenance  
- AI extension  

The **AI-DIGEST.txt** is the single source of truth for AI.

---

# 5. Workflows

## 5.1 Environment Initialization
See **Bootstrap-Windows.md** for:

- Installing Podman Desktop  
- Creating dev‑box‑vscode  
- Initializing inner Podman  

## 5.2 Adding a New Dev Container
1. Create a new folder under `/containers/` or `/projects/`  
2. Add a `devcontainer.json`  
3. Add a Dockerfile or image reference  
4. Rebuild under inner Podman  
5. Connect via VS Code  

## 5.3 AI Sandbox Workflow
1. Start the AI Sandbox Dev Container  
2. Launch model containers inside it  
3. Expose ports as needed  
4. Connect tools or agents  

## 5.4 Reset Workflow
- Rebuild dev‑box‑vscode  
- Rebuild Dev Containers  
- Rebuild model containers  
- Restore volumes if needed  

---

# 6. Diagram Suite

The Studio includes a complete diagram suite:

- Structural diagrams  
- Behavioral diagrams  
- Advanced diagrams  
- Specialized diagrams  
- Dependency matrices  
- Cross‑dependency maps  
- Taxonomy and legend  

See `/diagrams/README.md` for details.

---

# 7. Versioning and Change Management

The Studio uses:

- **AI-DIGEST.txt versioning**  
- **CHANGELOG.md** for all architectural changes  
- Optional **architecture semantic versioning**  

Any change to:

- Architecture  
- Workflows  
- Documentation  
- Diagrams  
- Constraints  

…must be reflected in the digest and the changelog.

---

# 8. Summary

The Studio Architecture is a:

- Windows‑native  
- Podman‑based  
- Fully isolated  
- Reproducible  
- Extensible  
- AI‑ready  

…platform for hosting **any** Dev Container.

It is a general‑purpose development Studio, not tied to any specific language or project.  
The architecture is stable, predictable, and designed for long‑term evolution.

