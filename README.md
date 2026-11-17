# claude-config

Repositorio con todos mis agentes genéricos para aplicar en proyectos JAVA.
Configuración personal de Claude Code versionada: agentes genéricos de nivel usuario.

> Solo contiene agentes genéricos. Los agentes específicos de un cliente o proyecto no se publican aquí.

## Estructura
```
claude-config/
├── agents/        # un .md por agente (cabecera YAML + prompt)
├── install.ps1    # enlaza agents/ en ~\.claude\agents
└── README.md
```

## Instalación en un PC nuevo (Windows)
```powershell
git clone <url-del-repo> $env:USERPROFILE\claude-config
powershell -ExecutionPolicy Bypass -File $env:USERPROFILE\claude-config\install.ps1
```
`install.ps1` crea un junction `~\.claude\agents` -> `claude-config\agents` (no necesita administrador).
Si ya existía una carpeta `agents`, la renombra a `agents.bak-<fecha>` en vez de borrarla.

## Añadir un agente
Crea `agents\<nombre>.md` con:
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
