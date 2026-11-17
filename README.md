# claude-config

Repositorio con todos mis agentes genéricos para aplicar en proyectos JAVA.
Configuración personal de Claude Code versionada: agentes genéricos de nivel usuario.

> Solo contiene agentes genéricos. Los agentes específicos de un cliente o proyecto no se publican aquí.

## Agentes incluidos
| Agente | Modelo | Herramientas | Para qué sirve |
|---|---|---|---|
| `api-documenter-java` | sonnet | Read, Write, Glob, Grep | Genera documentación Markdown de la API a partir del código (controladores, DTOs, validaciones, errores). |
| `db-analyst` | haiku | Bash, Read | Analiza datos con consultas **solo de lectura**: informes, integridad referencial, optimización de consultas. |
| `test-engineer-java` | sonnet | Read, Write, Edit, Bash, Grep, Glob | Genera y ejecuta tests unitarios y de integración (JUnit 5, Mockito) y reporta cobertura. |

## Estructura
```
claude-config/
├── agents/        # un .md por agente (cabecera YAML + prompt)
├── install.ps1    # Windows: enlaza agents/ en ~\.claude\agents
└── README.md
```

Claude Code lee los agentes de usuario de `~/.claude/agents/` (en Windows `C:\Users\<usuario>\.claude\agents\`).
La idea es que esa carpeta sea un **enlace** a `agents/` de este repo, de modo que cualquier cambio quede versionado.

## Instalación en Windows
```powershell
git clone https://github.com/cnfnavarro/claude-config.git $env:USERPROFILE\claude-config
powershell -ExecutionPolicy Bypass -File $env:USERPROFILE\claude-config\install.ps1
```
`install.ps1` crea un junction `~\.claude\agents` -> `claude-config\agents` (no necesita administrador).
Si ya existía una carpeta `agents`, la renombra a `agents.bak-<fecha>` en vez de borrarla.

## Instalación en macOS
Requisitos: `git` (viene con las Xcode Command Line Tools: `xcode-select --install`) y Claude Code instalado.

1. Clona el repo:
   ```bash
   git clone https://github.com/cnfnavarro/claude-config.git ~/claude-config
   ```
2. Si ya tienes una carpeta `~/.claude/agents` con agentes propios, guárdala como copia de seguridad (si no existe, este paso da un aviso y se puede ignorar):
   ```bash
   mkdir -p ~/.claude
   mv ~/.claude/agents ~/.claude/agents.bak-$(date +%Y%m%d-%H%M%S)
   ```
3. Crea el enlace simbólico hacia el repo:
   ```bash
   ln -s ~/claude-config/agents ~/.claude/agents
   ```
4. Comprueba que apunta bien y que están los agentes:
   ```bash
   ls -la ~/.claude/agents
   ls ~/.claude/agents/
   ```
   Debe mostrar `~/.claude/agents -> /Users/<usuario>/claude-config/agents` y los ficheros `.md`.
5. Abre Claude Code (o reinicia la sesión) y ejecuta `/agents` para ver que aparecen.

**Alternativa sin enlace (copia):** si prefieres no usar enlaces, copia los ficheros con
`mkdir -p ~/.claude/agents && cp ~/claude-config/agents/*.md ~/.claude/agents/`.
Con este método tendrás que repetir la copia cada vez que haya cambios en el repo.

## Actualizar los agentes
Con el enlace activo, basta con traer los cambios (Windows y macOS):
```bash
git -C ~/claude-config pull
```
En Windows PowerShell: `git -C $env:USERPROFILE\claude-config pull`.

## Añadir un agente
Crea `agents/<nombre>.md` con:
```markdown
---
name: <nombre-en-minusculas-con-guiones>
description: Qué hace, cuándo usarlo (disparadores), cuándo NO, qué devuelve.
tools: Read, Grep, Glob
model: sonnet
---
Prompt del sistema: rol, alcance, proceso, reglas, formato de salida, límites.
```
Después `git add`, `commit` y `push`.

Antes de subir un agente, comprueba que **no contiene rutas, nombres de sistemas ni datos de ningún cliente**: el repositorio es público.
