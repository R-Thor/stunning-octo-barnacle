# AI Collaboration Guide — Studio Architecture (Windows 11 Native)

Purpose:  
Explains how AI assistants should reason about the Windows‑native Studio Architecture, ensuring consistent, predictable, and safe guidance across all Dev Containers and workflows.

---

# 1. Host Interpretation (Windows 11)

The Windows host is:

- Immutable  
- Clean  
- Free of runtimes  
- Free of compilers  
- Free of SDKs (except those required by Visual Studio)  
- Only contains Podman Desktop + Visual Studio + IIS  

AI assistants must **never** assume:

- WSL exists  
- Docker exists  
- Linux runtimes exist on the host  
- The host contains Node, Python, Java, .NET SDKs, or any development tooling  

The host is a **hypervisor**, not a development environment.

---

# 2. dev‑box‑vscode Interpretation

The `dev‑box‑vscode` container is:

- The canonical Linux workstation  
- The location of all runtimes  
- The location of all tooling  
- The location of VS Code Server  
- The environment where **inner Podman** runs  
- The only place where development occurs  

AI assistants must treat dev‑box‑vscode as:

- The “developer machine”  
- The root of all Dev Container workflows  
- The execution environment for all commands unless explicitly stated otherwise  

---

# 3. Project Isolation

Each project has its own Dev Container(s):

- java‑dev  
- dotnet‑dev  
- ai‑sandbox‑dev  
- (future containers as needed)

AI assistants must:

- Treat each project as isolated  
- Avoid cross‑project assumptions  
- Never mix tooling or dependencies between containers  
- Assume each Dev Container is declarative, rebuildable, and disposable  

If a user is inside a project folder, the AI should assume:

- VS Code will attach to the correct Dev Container  
- All commands run **inside that container**, not on the host  

---

# 4. Windows‑Native Exceptions

Some workloads require the Windows kernel and must run on the host:

- Visual Studio workloads  
- IIS workloads  
- Windows SDKs  
- Windows services  
- .NET Framework (non‑Core) applications  

AI assistants must:

- Recognize these as **host‑only** tasks  
- Avoid suggesting containerization for Windows‑kernel workloads  

---

# 5. Philosophy of the Studio Architecture

AI assistants must internalize the following principles:

### The container is the workstation  
All development happens inside dev‑box‑vscode or a project Dev Container.

### The host is the hypervisor  
Windows runs Podman Desktop and nothing else.

### Isolation is intentional  
Each project has its own environment, dependencies, and tooling.

### Reproducibility is required  
All environments are:

- Declarative  
- Deterministic  
- Rebuildable  

### Predictability is essential  
AI assistants must avoid:

- Introducing new layers  
- Suggesting nested Podman hosts  
- Suggesting Docker  
- Suggesting WSL  
- Suggesting host‑installed runtimes  

---

# 6. AI Assistant Behavior Guidelines

AI assistants should:

- Provide instructions that run **inside the correct Dev Container**  
- Use container‑safe commands  
- Assume Podman, not Docker  
- Assume Linux tooling inside containers  
- Assume Windows tooling only for Windows‑native workloads  
- Maintain consistency with the Studio Architecture documentation  

AI assistants should **not**:

- Suggest installing tools on Windows  
- Suggest using WSL  
- Suggest using Docker  
- Suggest running commands outside dev‑box‑vscode unless explicitly required  

---

# 7. Summary

AI assistants must treat the Studio Architecture as:

- A Windows‑native, Podman‑only system  
- Centered around dev‑box‑vscode  
- Powered by inner Podman  
- Organized into isolated Dev Containers  
- Extended by a dedicated AI Sandbox  

This guide ensures that AI‑generated instructions remain consistent, predictable, and aligned with the Studio Architecture.
