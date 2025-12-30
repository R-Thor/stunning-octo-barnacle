# AI Sandbox  
A dedicated Dev Container for local model servers, agent frameworks, and AI experimentation

The **AI Sandbox** is a core component of the Enterprise environment. It provides a fully isolated Dev Container designed specifically for running local model servers, experimenting with agent frameworks, and building AI-driven tools — all without contaminating project Dev Containers or the host system.

This document describes the purpose, structure, workflows, and model container orchestration of the AI Sandbox.

---

# 1. Purpose of the AI Sandbox

The AI Sandbox exists to:

- Provide a **controlled environment** for AI experimentation  
- Run **local model servers** (Ollama, LM Studio, OpenAI-compatible servers)  
- Support **agent frameworks** and AI tooling  
- Keep AI workloads **isolated** from project Dev Containers  
- Maintain **deterministic, reproducible AI environments**  
- Serve as the **logical home** for all model containers  

The AI Sandbox is intentionally separated from Java, .NET, and other project Dev Containers.

---

# 2. Architectural Placement

The AI Sandbox is a Dev Container running under the **inner Podman** instance inside `dev-box`.

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

### Key Points

- The AI Sandbox is **not** a Podman host  
- It is a **Dev Container**  
- All model containers run under the **same inner Podman** as the project Dev Containers  
- Model containers are **logically grouped** under the AI Sandbox  
- Project Dev Containers do **not** run model servers  

---

# 3. AI Sandbox Dev Container

## 3.1 Purpose

The AI Sandbox Dev Container provides:

- A reproducible environment for AI development  
- A workspace for agent frameworks  
- Tools for interacting with local model servers  
- Scripts for starting/stopping model containers  
- A clean separation from project Dev Containers  

## 3.2 Typical Contents

The AI Sandbox Dev Container may include:

- Python + venv  
- Node.js (optional)  
- Agent frameworks (LangChain, Semantic Kernel, etc.)  
- CLI tools for interacting with model servers  
- Scripts for orchestrating model containers  
- Shared volumes for model weights  

Everything inside this container is isolated from Java and .NET Dev Containers.

---

# 4. Model Containers

Model containers run under **inner Podman**, not inside the AI Sandbox container itself.

They are siblings to project Dev Containers but are **logically associated** with the AI Sandbox.

## 4.1 Model Container Layout

    ai-sandbox-dev
      └── [Model Containers]
            ├── ollama
            ├── lmstudio
            └── openai-compatible servers

## 4.2 Supported Model Containers

### **Ollama**
Runs local LLMs with GPU/CPU acceleration.  
Used for:

- Embeddings  
- Chat models  
- Local inference  

### **LM Studio**
Runs GGUF models with a local API.  
Used for:

- OpenAI-compatible inference  
- Local model experimentation  

### **OpenAI-Compatible Servers**
Examples:

- `llama-cpp-python` server mode  
- `text-generation-inference`  
- Custom FastAPI-based model servers  

Used for:

- API-compatible testing  
- Agent framework integration  
- Multi-model orchestration  

---

# 5. Networking Model

All model containers share the same inner Podman network namespace as the AI Sandbox and project Dev Containers.

This ensures:

- Predictable port mappings  
- Stable container-to-container communication  
- No cross-layer networking issues  

Typical ports:

- Ollama: `11434`  
- LM Studio: `1234` (varies)  
- Custom servers: user-defined  

---

# 6. Storage Model

Model containers may mount volumes for:

- Model weights  
- Embeddings  
- Indexes  
- Cache directories  

These volumes are:

- Explicitly defined  
- Persistent  
- Isolated from project Dev Containers  

---

# 7. Workflow

## 7.1 Starting the AI Sandbox

1. Start WSL2  
2. Start `dev-box`  
3. Enter `dev-box`  
4. Launch VS Code from inside `dev-box`  
5. Open the `ai-sandbox` folder  
6. VS Code attaches to `ai-sandbox-dev`  

## 7.2 Starting Model Containers

From inside the AI Sandbox Dev Container:

- Run provided scripts (e.g., `./start-ollama.sh`)  
- Or use Podman commands directly  
- Or use VS Code tasks  

Model containers run independently of the AI Sandbox container itself.

## 7.3 Using Model Servers

Inside the AI Sandbox Dev Container:

- Call model APIs  
- Run agent frameworks  
- Test prompts  
- Build AI tools  

Project Dev Containers may optionally consume model APIs if configured.

---

# 8. Design Principles

## 8.1 Isolation
AI workloads are isolated from project Dev Containers.

## 8.2 Reproducibility
All model containers and the AI Sandbox Dev Container are declarative and rebuildable.

## 8.3 Predictability
No nested Podman hosts.  
No implicit networking.  
No hidden dependencies.

## 8.4 AI-First Documentation
All documentation is structured for AI assistants to:

- Parse  
- Reason  
- Maintain  
- Extend  

---

# 9. Extending the AI Sandbox

Possible extensions:

- GPU-enabled model containers  
- Multi-model routing  
- Embedding databases  
- Vector search engines  
- Agent orchestration frameworks  
- Automated model startup scripts  

All extensions must preserve:

- Isolation  
- Reproducibility  
- Predictability  

---

# 10. Summary

The AI Sandbox is the dedicated environment for all AI experimentation within the Enterprise architecture. It provides:

- A clean Dev Container  
- A predictable model container layout  
- A reproducible environment for AI development  
- A logical home for all local model servers  

This document serves as the authoritative reference for the AI Sandbox.
