# Enterprise Architecture Diagrams

## High-Level System Architecture

```txt
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
```

---

## Project Workflows

```txt
dev-box → code . → VS Code → Dev Container → Development
```

---

## Documentation Structure

```txt
Enterprise.md
AI-Sandbox.md
Java-Project.md
DotNet-Project.md
DevBox.md
Bootstrap.md
Glossary.md
Diagram-Only.md
```
