Dev‑Box‑VSCode (Windows 11 Native Architecture)

Purpose:
Defines the canonical development environment architecture for Windows 11 using Podman as the sole container engine. The host remains clean and immutable, while all development occurs inside a Fedora-based dev‑box‑vscode container.

1. Host Architecture (Windows 11)
The Windows host acts as a hypervisor, not a development machine.

Host Contains:
- Windows 11
- Podman Desktop
- Visual Studio (Windows-native workloads)
- IIS (Windows-native workloads)
- Git for Windows (optional)

Host Does NOT Contain:
- No runtimes (Node, Python, Go, Rust, etc.)
- No compilers
- No SDKs (except those required by Visual Studio)
- No VS Code Desktop (optional)
- No Docker
- No WSL

The host remains clean, stable, and predictable.

2. dev‑box‑vscode Container (Canonical Linux Workstation)
This container is the primary development environment.

Contains:
- Fedora base image
- VS Code Server
- Podman (nested)
- All runtimes
- All language servers
- All tooling

Behaviors:
- Acts as a full Linux workstation
- Provides VS Code UI via remote connection
- Runs nested containers for project isolation
- Rebuilt deterministically from Containerfile

3. Project Containers (Isolated Environments)
Each project has its own container(s):
- Isolated runtimes
- Isolated dependencies
- Isolated VS Code workspace settings
- Zero cross-contamination

4. Windows-Native Exceptions
Some workloads require the Windows kernel and must run on the host:
- Visual Studio
- IIS
- Windows SDKs
- Windows services
- .NET Framework apps

5. Philosophy
- The container is the workstation
- The host is the hypervisor
- Everything is reproducible
- Everything is isolated
- Nothing leaks onto the host

