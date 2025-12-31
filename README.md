# repo: stunning-octo-barnacle

# Studio Architecture  
A fully isolated, reproducible, AI‑ready development system  
(Windows 11 Native, Podman‑only)

The **Studio Architecture** is an abstract, container‑orchestrated development platform designed to host **any** Dev Container: labs, proofs of concept, sandboxes, experiments, training environments, or full project workspaces. It provides a deterministic, Windows‑native environment with strict isolation, reproducibility, and zero host pollution.

The Studio is not tied to any specific language or project.  
Java, .NET, and the AI Sandbox are **examples**, not fixed components.

This repository contains all documentation, diagrams, and workflows needed to understand, maintain, and extend the Studio.

---

# 1. Overview

The Studio Architecture is built on a clean, layered model:

- Windows 11  
- Podman Desktop  
- dev‑box-vscode (Canonical Workstation)  
- Podman (inner)  
- Arbitrary Dev Containers (labs, POCs, sandboxes, projects)  
- Optional AI Sandbox Dev Container with model servers  

This structure ensures:

- Deterministic builds  
- Fully isolated environments  
- Reproducible workflows  
- Clean separation between system layers  
- AI‑first documentation and tooling  
- A stable platform for hosting any number of Dev Containers  

---

# 2. High‑Level Architecture Diagram

```
Windows 11
  └── Podman Desktop
        └── dev-box-vscode
              └── Podman (inner)
                    ├── ai-sandbox-dev (optional Dev Container)
                    │     └── [Model Containers]
                    │           ├── ollama
                    │           ├── lmstudio
                    │           └── openai-compatible servers
                    ├── java-dev (example Dev Container)
                    ├── dotnet-dev (example Dev Container)
                    └── [arbitrary additional Dev Containers]
```

---

# 3. Key Concepts

### dev‑box‑vscode  
A persistent Fedora‑based container acting as the “developer workstation.”  
VS Code connects via SSH or browser, ensuring all Dev Containers run under the same inner Podman instance.

### Inner Podman  
The single container engine responsible for:

- Arbitrary Dev Containers  
- Optional AI Sandbox  
- Optional model containers  

### Arbitrary Dev Containers  
The Studio can host any number of Dev Containers, including:

- Labs  
- Proofs of concept  
- Sandboxes  
- Experiments  
- Training environments  
- Full project workspaces  

Each Dev Container is:

- isolated  
- reproducible  
- self‑contained  
- disposable  

Java and .NET are examples only.

### AI Sandbox (optional)  
A specialized Dev Container for:

- Running local model servers  
- Experimenting with agent frameworks  
- Building AI‑driven tools  
- Keeping AI workloads isolated from project environments  

---

# 4. Documentation

| File | Purpose |
|------|---------|
| Studio-Architecture.md | Full architecture description |
| AI-Sandbox.md | AI Sandbox design + model container details |
| Java-Project.md | Example Java Dev Container workflow |
| DotNet-Project.md | Example .NET Dev Container workflow |
| Dev-Box-VSCode.md | dev‑box‑vscode container details |
| Bootstrap-Windows.md | Steps to initialize the environment |
| Glossary.md | Definitions of all architectural terms |
| Diagram-only-Windows.md | All diagrams in one place |
| AI-DIGEST.txt | Unified AI context + architectural summary |

---

# 5. Philosophy

### Isolation  
Every Dev Container is fully isolated.  
No shared dependencies.  
No host contamination.

### Reproducibility  
Every environment is:

- Declarative  
- Deterministic  
- Rebuildable  

### Predictability  
The system avoids unnecessary complexity:

- No Podman‑in‑Podman‑in‑Podman  
- No hidden side effects  
- No implicit networking  

### AI‑First Documentation  
All documentation is structured so AI assistants can:

- Parse it  
- Reason over it  
- Maintain it  
- Extend it  

The **AI-DIGEST.txt** is the single source of truth for AI.

---

# 6. Getting Started

See **Bootstrap-Windows.md** for:

- Initial setup  
- Environment creation  
- dev‑box‑vscode startup  
- VS Code integration  
- Adding or running Dev Containers  

---

# 7. AI Assistant Usage

If you are using Copilot or another AI assistant:

- Load **AI-DIGEST.txt** as context  
- Follow the architectural constraints  
- Maintain consistency with the documentation  
- Avoid introducing new layers or abstractions unless requested  

---

# 8. License

This repository is provided as‑is for personal or organizational use.  
You may adapt or extend the architecture to fit your environment.

---

# 9. Contact

For questions, improvements, or architectural extensions, open an issue or start a discussion in your repo.
