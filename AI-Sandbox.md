# AI Sandbox  
A specialized Dev Container for isolated AI experimentation

The **AI Sandbox** is an optional Dev Container within the Studio Architecture designed for running local model servers, experimenting with agent frameworks, and building AI‑driven tools. It provides a fully isolated environment for AI workloads without affecting project Dev Containers or the host system.

The AI Sandbox is not required for the Studio to function.  
It is a **specialized container pattern** that can be added, removed, or replaced at any time.

---

# 1. Purpose

The AI Sandbox exists to:

- Provide a controlled environment for AI experimentation  
- Run local model servers (Ollama, LM Studio, OpenAI‑compatible APIs, etc.)  
- Host agent frameworks and orchestration tools  
- Keep AI workloads isolated from project Dev Containers  
- Allow reproducible AI workflows  
- Support rapid prototyping of AI‑driven features  
- Avoid polluting project environments with AI dependencies  

The Sandbox is a **tooling container**, not a project container.

---

# 2. Architectural Position

The AI Sandbox runs under **inner Podman**, inside the persistent `dev-box-vscode` workstation.

```
Windows 11
  └── Podman Desktop
        └── dev-box-vscode
              └── Podman (inner)
                    ├── [Arbitrary Dev Containers]
                    └── ai-sandbox-dev (optional)
                          └── [Model Containers]
                                ├── ollama
                                ├── lmstudio
                                └── openai-compatible servers
```

This ensures:

- AI workloads never touch the host  
- All model servers run in a predictable environment  
- AI tools share the same network namespace  
- Project containers remain clean and isolated  

---

# 3. Components of the AI Sandbox

The AI Sandbox typically includes:

### 3.1 Base Dev Container  
A Fedora‑ or Ubuntu‑based Dev Container with:

- Python  
- Node.js (optional)  
- CUDA or ROCm support (optional, GPU‑dependent)  
- Common AI tooling  
- CLI utilities  
- Networking tools  

This is the “AI workstation.”

---

### 3.2 Model Containers  
Model servers run as **separate containers** inside the Sandbox.

Common examples:

- **Ollama**  
  - Local LLM runner  
  - Pulls models on demand  
  - Exposes an OpenAI‑compatible API  

- **LM Studio Server**  
  - Local inference server  
  - Supports GGUF models  
  - Exposes an OpenAI‑compatible API  

- **OpenAI‑compatible servers**  
  - vLLM  
  - llama.cpp server mode  
  - custom inference servers  

These containers are:

- isolated  
- disposable  
- reproducible  
- easy to rebuild  

---

### 3.3 Agent Frameworks (optional)
The Sandbox may include frameworks such as:

- LangChain  
- LlamaIndex  
- Semantic Kernel  
- CrewAI  
- Custom agent runtimes  

These are installed **inside the Sandbox Dev Container**, not the model containers.

---

# 4. Networking Model

The AI Sandbox uses a simple, predictable networking pattern:

- The Sandbox Dev Container communicates with model containers via localhost‑mapped ports  
- Model containers expose ports like `11434`, `1234`, or `8000`  
- Project Dev Containers may optionally connect to the Sandbox via shared Podman networks  

Example:

```
ai-sandbox-dev → localhost:11434 → ollama
ai-sandbox-dev → localhost:8000  → openai-compatible server
```

Project containers **do not** run model servers directly.

---

# 5. Workflow

## 5.1 Starting the AI Sandbox
1. Start `dev-box-vscode`  
2. Open a terminal inside it  
3. Start the AI Sandbox Dev Container via inner Podman  
4. Attach VS Code to the Sandbox if needed  

---

## 5.2 Running Model Containers
From inside the AI Sandbox:

```
podman run -d -p 11434:11434 ollama/ollama
podman run -d -p 8000:8000 lmstudio/server
```

Or use Podman Compose for multi‑model setups.

---

## 5.3 Using the Sandbox from Projects
Project Dev Containers can call model APIs by:

- Using shared Podman networks  
- Mapping ports through the Sandbox  
- Using environment variables for endpoints  

Example:

```
OPENAI_API_BASE=http://ai-sandbox-dev:8000/v1
```

---

## 5.4 Resetting the Sandbox
To reset:

- Stop model containers  
- Remove them  
- Rebuild the Sandbox Dev Container  
- Re‑pull models if needed  

This ensures reproducibility.

---

# 6. Patterns and Best Practices

### 6.1 Keep AI workloads isolated  
Never install AI tooling directly into project Dev Containers.

### 6.2 Use model containers, not local binaries  
Model servers should run in containers for reproducibility.

### 6.3 Treat the Sandbox as disposable  
It should be easy to rebuild at any time.

### 6.4 Use environment variables for endpoints  
Avoid hard‑coding model URLs.

### 6.5 Document model versions  
Model reproducibility matters.

---

# 7. Example File Structure

```
/ai-sandbox/
  ├── devcontainer.json
  ├── Dockerfile
  ├── compose.yaml
  ├── scripts/
  │     ├── start-ollama.sh
  │     ├── start-lmstudio.sh
  │     └── start-openai-server.sh
  └── README.md
```

This structure is optional and customizable.

---

# 8. When to Use the AI Sandbox

Use the Sandbox when you need:

- Local LLM inference  
- Agent experimentation  
- Model evaluation  
- Prompt engineering  
- AI‑driven tooling  
- Offline or private inference  
- Reproducible AI workflows  

Do **not** use it for:

- Project‑specific dependencies  
- Language runtimes  
- Build tooling  
- Application servers  

Those belong in project Dev Containers.

---

# 9. Summary

The AI Sandbox is an optional, specialized Dev Container that provides:

- A clean environment for AI experimentation  
- Local model servers running in isolated containers  
- A reproducible, deterministic workflow  
- Zero contamination of project environments  
- A flexible, extensible pattern for AI development  

It is a **tooling container**, not a project container.  
It enhances the Studio but does not define it.

