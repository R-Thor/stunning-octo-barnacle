# Dependency Matrix Legend

The dependency matrix uses the following symbols and meanings:

### ✓  (Depends On)
The diagram **builds upon**, **requires**, or **logically derives from** the referenced diagram.  
This means:
- It uses concepts defined in that diagram  
- It visually or structurally extends it  
- It cannot be fully understood without it  

### —  (Self)
Indicates the diagram’s own row.  
No dependency is implied.

### Blank Cell
No direct dependency.  
The diagram does **not** rely on or extend the referenced diagram.

---

## Dependency Types (Conceptual)

### Structural Dependency
A diagram relies on foundational architectural structure  
(e.g., Layered Architecture → Network Topology).

### Behavioral Dependency
A diagram relies on workflow or lifecycle definitions  
(e.g., Sequence → Data Flow).

### Advanced Dependency
A diagram relies on security or data‑flow abstractions  
(e.g., Security Boundaries → AI Sandbox Topology).

### Specialized Dependency
A diagram relies on subsystem‑specific definitions  
(e.g., Env Vars → Mega Architecture).

---

## How to Read the Matrix

- **Rows** = a diagram  
- **Columns** = what that diagram depends on  
- **✓** = dependency exists  
- **—** = same diagram  
- **blank** = no dependency  

Example:  
If the row for `Diagram-sequence` has a ✓ under `Network Topology`,  
it means the sequence diagram **requires** the network topology to be understood.

---

This legend is now ready to be placed directly under your dependency matrix or in your `diagrams/README.md` if you want a fully self‑documenting diagram suite.