# repo: stunning-octo-barnacle

# Studio Architecture  
A fully isolated, reproducible, AI‑ready development system  
(Windows 11 Native, Podman‑only)

The **Studio Architecture** is a structured, deterministic development environment designed for engineers who value isolation, reproducibility, and clean separation of concerns. It provides a complete workflow for running multiple project Dev Containers, an AI Sandbox with local model servers, and a unified Podman‑based architecture that ensures zero host pollution.

This repository contains all documentation, diagrams, and workflows needed to understand, maintain, and extend the system.

---

# 1. Overview

The Studio Architecture is built on a clean, Windows‑native layered model:

- Windows 11  
- Podman Desktop  
- dev‑box‑vscode (Canonical Workstation)  
- Podman (inner)  
- Multiple Dev Containers for projects  
- AI Sandbox Dev Container with model containers  

This structure ensures:

- Deterministic builds  
- Fully isolated project environments  
- Reproducible workflows  
- Clean separation between system layers  
- AI‑first documentation and tooling  

---

# 2. High‑Level Architecture Diagram

    Windows 11
      └── Podman Desktop
            └── dev-box-vscode
                  └── Podman (inner)
                        ├── ai-sandbox-dev (Dev Container)
                        │     └── [Model Containers]
                        │           ├── ollama
                        │           ├── lmstudio
                        │           └── openai-compatible servers
                        ├── java-dev (Dev Container)
                        └── dotnet-dev (Dev Container)

---

# 3. Key Concepts

### dev‑box‑vscode  
A persistent Fedora‑based container that acts as the “developer workstation.”  
VS Code connects to dev‑box‑vscode via SSH or browser, ensuring all Dev Containers run under the same inner Podman instance.

### Inner Podman  
The single container engine responsible for:

- Project Dev Containers  
- AI Sandbox Dev Container  
- Model containers (Ollama, LM Studio, OpenAI‑compatible servers)

### AI Sandbox  
A dedicated Dev Container for:

- Running local model servers  
- Experimenting with agent frameworks  
- Building AI‑driven tools  
- Keeping AI workloads isolated from project environments  

### Project Dev Containers  
Each project (Java, .NET, etc.) runs in its own Dev Container with:

- Its own dependencies  
- Its own tooling  
- Its own isolated environment  

---

# 4. Documentation

| File | Purpose |
|------|---------|
| Studio-Architecture.md | Full architecture description |
| AI-Sandbox.md | AI Sandbox design + model container details |
| Java-Project.md | Java project Dev Container workflow |
| DotNet-Project.md | .NET project Dev Container workflow |
| Dev-Box-VSCode.md | dev‑box‑vscode container details |
| Bootstrap-Windows.md | Steps to initialize the environment |
| Glossary.md | Definitions of all architectural terms |
| Diagram-only-Windows.md | All diagrams in one place |
| AI.COPILOT-Windows.md | AI context + architectural summary |

---

# 5. Philosophy

### Isolation  
Every project runs in its own Dev Container.  
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

---

# 6. Getting Started

See **Bootstrap-Windows.md** for:

- Initial setup  
- Environment creation  
- dev‑box‑vscode startup  
- VS Code integration  
- Project workflows  

---

# 7. AI Assistant Usage

If you are using Copilot or another AI assistant:

- Load **AI.COPILOT-Windows.md** as context  
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
