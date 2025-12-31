AI Collaboration Guide — Windows 11 Native Architecture

Purpose:
Explains how AI assistants should reason about the Windows-native development environment.

1. Host Interpretation
The Windows host is:
- Immutable
- Clean
- Free of runtimes
- Only contains Podman Desktop + Visual Studio + IIS

AI should never assume:
- WSL exists
- Docker exists
- Host contains compilers or runtimes

2. dev‑box‑vscode Interpretation
The dev‑box‑vscode container is:
- The canonical Linux workstation
- The location of all runtimes
- The location of all tooling
- The location of VS Code Server
- The environment for nested Podman

3. Project Isolation
Each project has its own container(s).
AI should:
- Treat each project as isolated
- Avoid cross-project assumptions

4. Windows-Native Exceptions
AI should recognize:
- Visual Studio workloads run on host
- IIS workloads run on host
- .NET Framework workloads run on host

5. Philosophy
- The container is the workstation
- The host is the hypervisor
- Isolation is intentional
- Reproducibility is required

