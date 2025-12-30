# Java Project Dev Container  
Isolated, reproducible Java development inside the Enterprise environment

The java-dev Dev Container provides a fully isolated, deterministic environment for building and running Java applications within the Enterprise architecture. This document describes the structure, tooling, workflows, and best practices for Java development inside this system.

---

# 1. Purpose of the Java Dev Container

The Java Dev Container exists to:

- Provide a clean, reproducible Java environment  
- Isolate Java tooling from the host and other projects  
- Ensure deterministic builds using containerized JDK + Maven/Gradle  
- Support debugging and development through VS Code Dev Containers  
- Integrate cleanly with the Enterprise layered architecture  

The container is disposable, rebuildable, and fully declarative.

---

# 2. Architectural Placement

The Java Dev Container runs under the inner Podman instance inside dev-box.

    Windows 11
      └── WSL2: Debian-Enterprise
            └── Podman (host)
                  └── dev-box
                        └── Podman (inner)
                              ├── ai-sandbox-dev (Dev Container)
                              ├── java-dev (Dev Container)
                              └── dotnet-dev (Dev Container)

Key points:

- java-dev is a sibling to dotnet-dev and ai-sandbox-dev  
- It is not nested inside other containers  
- It uses the same inner Podman as all other Dev Containers  
- VS Code attaches to java-dev automatically when opening the Java project folder  

---

# 3. Container Contents

The java-dev container typically includes:

## Java Tooling
- JDK (Temurin or OpenJDK)  
- Maven and/or Gradle  
- Java Debug Adapter  
- Language Server Protocol (LSP) support  

## Development Tools
- Git  
- Shell utilities  
- Build tools  
- Optional: Node.js for hybrid projects  

## VS Code Integration
- Java extension pack  
- Debugger for Java  
- Maven/Gradle extensions  
- Test runner integrations  

Everything is isolated from the host and other Dev Containers.

---

# 4. Project Structure

A typical Java project folder looks like:

    java-project/
      ├── .devcontainer/
      │     └── devcontainer.json
      ├── src/
      │     ├── main/
      │     └── test/
      ├── pom.xml        (Maven)
      └── build.gradle   (Gradle)

Only one build system is required — Maven or Gradle.

---

# 5. Workflow

## 5.1 Opening the Project

1. Start WSL2  
2. Start dev-box  
3. Enter dev-box  
4. Launch VS Code from inside dev-box  
5. Open the Java project folder  
6. VS Code detects .devcontainer  
7. VS Code attaches to java-dev  

You are now inside the isolated Java environment.

---

## 5.2 Building the Project

### Maven
    mvn clean install

### Gradle
    ./gradlew build

Builds are deterministic because:

- The JDK is containerized  
- The build tool is containerized  
- Dependencies are cached inside the container  

---

## 5.3 Running the Application

### Maven
    mvn spring-boot:run

### Gradle
    ./gradlew bootRun

Or run directly:

    java -jar target/app.jar

---

## 5.4 Debugging

VS Code provides:

- Breakpoints  
- Step-through debugging  
- Variable inspection  
- Hot reload (framework-dependent)  

Debugging works automatically because the Java Debug Adapter is installed inside the container.

---

# 6. Networking

The Java Dev Container shares the same inner Podman network namespace as:

- ai-sandbox-dev  
- dotnet-dev  
- All model containers  

This allows optional access to:

- Local LLMs  
- Embedding servers  
- AI inference endpoints  

Access is not enabled by default — the developer must configure it explicitly.

---

# 7. Storage Model

The Java Dev Container may define volumes for:

- Maven cache (~/.m2)  
- Gradle cache (~/.gradle)  
- Build artifacts  

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
- Use containerized JDK and build tools  
- Rebuild the container when dependencies change  
- Use VS Code tasks for common workflows  
- Keep the .devcontainer folder declarative and minimal  

---

# 10. Summary

The Java Dev Container provides:

- A clean, isolated Java environment  
- Deterministic builds  
- Full VS Code integration  
- Predictable networking  
- Zero host pollution  

This document serves as the authoritative reference for Java development inside the Enterprise architecture.
