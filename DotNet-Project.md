# .NET Project Dev Container  
Isolated, reproducible .NET development inside the Enterprise environment

The dotnet-dev Dev Container provides a fully isolated, deterministic environment for building and running .NET applications within the Enterprise architecture. This document describes the structure, tooling, workflows, and best practices for .NET development inside this system.

---

# 1. Purpose of the .NET Dev Container

The .NET Dev Container exists to:

- Provide a clean, reproducible .NET environment  
- Isolate .NET SDKs and tooling from the host and other projects  
- Ensure deterministic builds using containerized .NET runtimes  
- Support debugging and development through VS Code Dev Containers  
- Integrate cleanly with the Enterprise layered architecture  

The container is disposable, rebuildable, and fully declarative.

---

# 2. Architectural Placement

The .NET Dev Container runs under the inner Podman instance inside dev-box.

    Windows 11
      └── WSL2: Debian-Enterprise
            └── Podman (host)
                  └── dev-box
                        └── Podman (inner)
                              ├── ai-sandbox-dev (Dev Container)
                              ├── java-dev (Dev Container)
                              └── dotnet-dev (Dev Container)

Key points:

- dotnet-dev is a sibling to java-dev and ai-sandbox-dev  
- It is not nested inside other containers  
- It uses the same inner Podman as all other Dev Containers  
- VS Code attaches to dotnet-dev automatically when opening the .NET project folder  

---

# 3. Container Contents

The dotnet-dev container typically includes:

## .NET Tooling
- .NET SDK (LTS version)  
- ASP.NET Core runtime  
- NuGet CLI  
- .NET Debug Adapter  
- Language Server Protocol (LSP) support  

## Development Tools
- Git  
- Shell utilities  
- Build tools  
- Optional: Node.js for frontend or Blazor hybrid projects  

## VS Code Integration
- C# Dev Kit  
- .NET Debugger  
- NuGet package manager  
- Test runner integrations  

Everything is isolated from the host and other Dev Containers.

---

# 4. Project Structure

A typical .NET project folder looks like:

    dotnet-project/
      ├── .devcontainer/
      │     └── devcontainer.json
      ├── src/
      │     └── ProjectName/
      │           ├── Program.cs
      │           ├── Startup.cs (if applicable)
      │           └── ProjectName.csproj
      ├── tests/
      │     └── ProjectName.Tests/
      │           └── ProjectName.Tests.csproj
      └── global.json (optional SDK pinning)

---

# 5. Workflow

## 5.1 Opening the Project

1. Start WSL2  
2. Start dev-box  
3. Enter dev-box  
4. Launch VS Code from inside dev-box  
5. Open the .NET project folder  
6. VS Code detects .devcontainer  
7. VS Code attaches to dotnet-dev  

You are now inside the isolated .NET environment.

---

## 5.2 Building the Project

    dotnet build

Builds are deterministic because:

- The .NET SDK is containerized  
- Dependencies are cached inside the container  
- The environment is fully reproducible  

---

## 5.3 Running the Application

### Console app
    dotnet run --project src/ProjectName

### Web API / ASP.NET Core
    dotnet watch run --project src/ProjectName

Hot reload works automatically inside the container.

---

## 5.4 Testing

    dotnet test

Test results appear directly in VS Code’s Test Explorer.

---

## 5.5 Debugging

VS Code provides:

- Breakpoints  
- Step-through debugging  
- Variable inspection  
- Hot reload (framework-dependent)  

Debugging works automatically because the .NET Debug Adapter is installed inside the container.

---

# 6. Networking

The .NET Dev Container shares the same inner Podman network namespace as:

- ai-sandbox-dev  
- java-dev  
- All model containers  

This allows optional access to:

- Local LLMs  
- Embedding servers  
- AI inference endpoints  

Access is not enabled by default — the developer must configure it explicitly.

---

# 7. Storage Model

The .NET Dev Container may define volumes for:

- NuGet cache (~/.nuget/packages)  
- Build artifacts  
- Temporary files  

These caches are isolated and do not affect other Dev Containers.

---

# 8. Rebuilding the Container

To rebuild:

1. Open the Command Palette  
2. Run: Dev Containers: Rebuild Container  

This ensures:

- A clean environment  
- Updated dependencies  
- Deterministic builds  

Containers are disposable — rebuilding is encouraged.

---

# 9. Best Practices

- Keep all tooling inside the container  
- Avoid installing anything on the host  
- Use containerized .NET SDKs  
- Rebuild the container when dependencies change  
- Use VS Code tasks for common workflows  
- Keep the .devcontainer folder declarative and minimal  

---

# 10. Summary

The .NET Dev Container provides:

- A clean, isolated .NET environment  
- Deterministic builds  
- Full VS Code integration  
- Predictable networking  
- Zero host pollution  

This document serves as the authoritative reference for .NET development inside the Enterprise architecture.
