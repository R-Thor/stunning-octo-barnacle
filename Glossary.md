# Glossary  
Definitions of all architectural terms used in the Enterprise environment

This glossary provides clear, authoritative definitions for all terms used throughout the Enterprise documentation suite. It ensures consistent language across all Dev Containers, diagrams, workflows, and AI interactions.

---

# A

### **AI Sandbox**
A dedicated Dev Container used for running local model servers, agent frameworks, and AI experimentation. It is a sibling to project Dev Containers and runs under inner Podman.

### **AI Sandbox Dev Container**
The Dev Container that hosts the AI development environment. It does not run model containers itself but orchestrates them via inner Podman.

### **AI-First Documentation**
A documentation style designed so AI assistants can parse, reason over, and extend the content without ambiguity.

---

# C

### **Containerfile**
The Podman-compatible file used to build containers (similar to Dockerfile). Each Dev Container and dev-box has its own Containerfile.

### **Clean Host**
A design principle ensuring that Windows and WSL2 contain no development tools. All development happens inside dev-box and Dev Containers.

---

# D

### **Debian-Enterprise**
The WSL2 Linux distribution used as the base environment. It runs Podman (host) and stores dev-box and project files.

### **Dev Container**
A containerized development environment defined by a `.devcontainer` folder. Each project (Java, .NET, AI Sandbox) has its own Dev Container.

### **Dev Container Architecture**
The structure in which all Dev Containers run under inner Podman inside dev-box, ensuring isolation and reproducibility.

### **dev-box**
The persistent developer workstation container. It runs under Podman (host) and contains inner Podman, VS Code CLI, Git, and developer tools.

---

# E

### **Enterprise Architecture**
The full layered system consisting of Windows → WSL2 → Podman (host) → dev-box → Podman (inner) → Dev Containers → Model Containers.

---

# I

### **Inner Podman**
The Podman instance running inside dev-box. It is the single container engine responsible for all Dev Containers and model containers.

### **Isolation**
A design principle ensuring that each project runs in its own Dev Container with no shared dependencies or host contamination.

---

# J

### **java-dev**
The Java Dev Container used for building and running Java applications. It includes JDK, Maven/Gradle, debugging tools, and VS Code integrations.

---

# L

### **Layered Architecture**
The hierarchical structure of the Enterprise environment, ensuring clean separation between system layers.

### **LM Studio Container**
A model container running LM Studio in server mode under inner Podman. Provides OpenAI-compatible inference endpoints.

---

# M

### **Model Container**
A container running a local model server (Ollama, LM Studio, OpenAI-compatible servers). These run under inner Podman and are logically grouped under the AI Sandbox.

### **Maven Cache / Gradle Cache**
Persistent volumes used by java-dev to store build dependencies.

---

# O

### **Ollama Container**
A model container running Ollama under inner Podman. Provides local LLM inference and embeddings.

---

# P

### **Podman (host)**
The Podman instance running inside WSL2. It runs dev-box and nothing else.

### **Podman (inner)**
The Podman instance running inside dev-box. It runs all Dev Containers and model containers.

### **Predictability**
A design principle ensuring no hidden side effects, no nested Podman hosts, and no implicit networking.

---

# R

### **Rebuild**
The process of recreating a Dev Container or dev-box from its Containerfile. Ensures deterministic environments.

### **Reproducibility**
A design principle ensuring that all environments are declarative, deterministic, and rebuildable.

---

# S

### **Sandbox**
Short for AI Sandbox. A controlled environment for AI experimentation.

### **Sibling Containers**
Containers that run under the same Podman instance and share the same network namespace. Example: java-dev, dotnet-dev, ai-sandbox-dev.

---

# T

### **Tooling Isolation**
The practice of keeping all development tools inside containers rather than installing them on Windows or WSL2.

---

# V

### **VS Code Dev Containers**
A VS Code feature that attaches the editor to a Dev Container, providing a fully containerized development environment.

### **Volumes**
Persistent storage used by dev-box, Dev Containers, and model containers for caches, configuration, and project files.

---

# W

### **WSL2**
Windows Subsystem for Linux 2. Provides the Linux environment where Podman (host) runs. It contains no development tools.

---

# Summary

This glossary defines all terminology used throughout the Enterprise documentation suite.  
It ensures consistent language for both human contributors and AI assistants working within the repository.
