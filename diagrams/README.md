# Diagram Suite — Studio Architecture  
Canonical Index for All Architecture Diagrams  
(Windows 11 Native, Podman‑Only)

This folder contains the complete diagram suite for the Studio Architecture.  
All diagrams follow a strict naming convention and taxonomy to ensure clarity, reproducibility, and AI‑friendly navigation.

---

# 1. Diagram Index

| Filename | Category | Description |
|---------|----------|-------------|
| `Diagram-only-Windows.ASCII` | Structural | High‑level ASCII overview of the architecture. |
| `Diagram-layered-architecture.mmd` | Structural | Layered system diagram (Host → Podman → dev‑box‑vscode → Inner Podman → Containers). |
| `Diagram-deployment.mmd` | Structural | Deployment view of all components. |
| `Diagram-class.mmd` | Structural | Class‑style representation of architectural entities. |
| `Diagram-erd.mmd` | Structural | Entity‑relationship diagram for architecture components. |
| `Diagram-network-topology.mmd` | Structural | Shared network namespace and container connectivity. |
| `Diagram-volume-mounts.mmd` | Structural | Volume layout for dev‑box‑vscode, Dev Containers, and model containers. |
| `Diagram-port-mappings.mmd` | Structural | Port allocation for Dev Containers and model servers. |
| `Diagram-sequence.mmd` | Behavioral | Sequence diagram for build/run/inference workflows. |
| `Diagram-state.mmd` | Behavioral | State transitions for containers and environments. |
| `Diagram-flowchart.mmd` | Behavioral | Flowchart for development workflows. |
| `Diagram-gantt.mmd` | Behavioral | Gantt chart for project timelines. |
| `Diagram-data-flow.mmd` | Advanced | Data flow across Dev Containers, AI Sandbox, and model containers. |
| `Diagram-security-boundaries.mmd` | Advanced | Security boundaries across host, workstation, Dev Containers, and models. |
| `Diagram-container-lifecycle.mmd` | Behavioral | Lifecycle of dev‑box‑vscode, Dev Containers, and model containers. |
| `Diagram-decision-tree.mmd` | Behavioral | Decision logic for where workloads should run. |
| `Diagram-timeline.mmd` | Behavioral | Timeline of resets, rebuilds, updates, and maintenance. |
| `Diagram-ai-sandbox-model-topology.mmd` | Specialized | AI Sandbox orchestration and model container topology. |
| `Diagram-env-vars.mmd` | Specialized | Environment variable mapping across all layers. |
| `Diagram-workspace-structure.mmd` | Structural | Repository folder structure and documentation layout. |
| `Diagram-volume-network-combined.mmd` | Structural | Combined view of volumes + network topology. |
| `Diagram-mega-architecture.mmd` | Structural | Full poster diagram of the entire architecture. |

All diagrams in the canonical checklist have been completed.  
This suite is **100% complete**.

---

# 2. Diagram Usage & Guidelines

## Cross‑References

| Document | Relevant Diagrams |
|----------|-------------------|
| `Studio-Architecture.md` | Layered Architecture, Deployment, Mega Architecture |
| `AI.COPILOT-Windows.md` | Decision Tree, Security Boundaries |
| `Dev-Box-VSCode.md` | Workspace Structure, Volume Mounts |
| `Java-Project.md` | Sequence, Port Mappings |
| `DotNet-Project.md` | Sequence, Port Mappings |
| `AI-Sandbox.md` (future) | AI Sandbox Topology, Env Vars, Data Flow |
| `Bootstrap-Windows.md` | Timeline, Container Lifecycle |
| `Glossary.md` | All diagrams referenced by term |

---

## Naming Conventions

All diagrams follow the canonical pattern:

- Diagram-<topic>.mmd
- Diagram-<topic>.ASCII

Where `<topic>` is:

- lowercase  
- hyphen‑separated  
- descriptive  
- stable across revisions  

Examples:

- `Diagram-network-topology.mmd`  
- `Diagram-ai-sandbox-model-topology.mmd`  
- `Diagram-mega-architecture.mmd`  

---

## Editing Guidelines

- Use **Mermaid** syntax unless ASCII is explicitly required.  
- Keep diagrams **declarative**, **deterministic**, and **AI‑parsable**.  
- Add new diagrams to this README when created.  
- Maintain architectural alignment with the Studio Architecture specification.  
- Avoid duplicating diagrams — each one has a unique purpose.  

---

## Purpose of the Diagram Suite

This suite exists to:

- Provide a complete visual reference for the Studio Architecture  
- Support onboarding, debugging, and architectural reviews  
- Enable AI assistants to reason about the system predictably  
- Maintain long‑term clarity and reproducibility  

---

If you'd like, I can now generate:

- A `/docs/README.md` to unify the entire documentation suite  
- A diagram taxonomy poster  
- A cross‑diagram dependency map  

Just tell me where you want to go next.
