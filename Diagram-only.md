# Architecture Diagrams — WSL + Podman‑in‑Podman

## 1. High-Level Architecture

+------------------------------------------------+
|                Windows 11 Host                 |
|  - WSL2                                         |
|  - Podman Desktop (optional)                    |
+------------------------------------------------+
                     |
                     v
+------------------------------------------------+
|                Fedora WSL Distro               |
|  - Systemd                                      |
|  - Podman                                       |
|  (Linux Kernel Provider)                        |
+------------------------------------------------+
                     |
                     v
+------------------------------------------------+
|              dev-box-vscode Container          |
|  - Fedora base                                  |
|  - VS Code Server                               |
|  - Podman (nested)                              |
|  - All runtimes                                 |
|  - All tooling                                  |
|  (Canonical Workstation)                        |
+------------------------------------------------+
                     |
                     v
+------------------------------------------------+
|            Project-Specific Containers         |
|  - Isolated                                     |
|  - Reproducible                                 |
|  - Deterministic                                |
+------------------------------------------------+
