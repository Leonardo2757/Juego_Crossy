# CrossyAnimal 🐾

Juego 3D estilo **Crossy Road** desarrollado en **Godot 4** como entrega de la Práctica 7.

![screenshot](screenshots/screenshot.png)

---

## Personaje

**Nombre:** CrossyBuddy  
**Descripción:** Personaje 3D voxel importado desde Blender (`.gltf`). Cuerpo compacto y colorido al estilo Crossy Road. Puede moverse en las cuatro direcciones del escenario y debe esquivar a los NPCs que patrullan los caminos.

---

## Controles de movimiento

| Tecla | Acción |
|-------|--------|
| `W` o `↑` | Avanzar |
| `S` o `↓` | Retroceder |
| `A` o `←` | Ir a la izquierda |
| `D` o `→` | Ir a la derecha |
| `ESC` | Reiniciar nivel |

---

## NPCs y comportamiento

| NPC | Color | Ruta | Velocidad |
|-----|-------|------|-----------|
| **NPC1 — Carro Rojo** | Rojo | Patrulla el camino superior de izquierda a derecha (x: -10 → 10) | 4 unidades/s |
| **NPC2 — Carro Naranja** | Naranja | Patrulla el camino inferior de derecha a izquierda (x: 10 → -10) | 2.5 unidades/s |

Ambos NPCs se mueven en **línea recta de punto A a punto B** y regresan al llegar al extremo, replicando el comportamiento de los vehículos en Crossy Road.

**Al colisionar con un NPC:**
- El jugador regresa a su posición de inicio.
- Se muestra el mensaje: *"¡Golpeaste un NPC! Vuelves al inicio"*
- El contador de intentos aumenta en 1.

---

## Estructura del proyecto

```
crossy_godot/
├── project.godot          # Configuración del proyecto (Input Map incluido)
├── icon.svg
├── scenes/
│   ├── Level.tscn         # Escena principal con suelo, caminos, Player y NPCs
│   ├── Player.tscn        # CharacterBody3D + colisión + cámara
│   ├── NPC.tscn           # CharacterBody3D + Area3D para detección
│   └── HUD.tscn           # CanvasLayer con labels de mensaje y contador
├── scripts/
│   ├── player.gd          # Movimiento WASD, reinicio de posición
│   ├── npc.gd             # Patrulla A→B, detección de jugador
│   ├── hud.gd             # Mostrar mensajes y contador de intentos
│   └── level.gd           # Reinicio de escena con ESC
├── models/                # Coloca aquí tu archivo .gltf del personaje
└── screenshots/
    └── screenshot.png
```

---

## Cómo importar tu modelo .gltf

1. Copia tu archivo `.gltf` (y la carpeta de texturas si existe) dentro de `models/`.
2. Godot lo importará automáticamente al abrir el proyecto.
3. En `Player.tscn`, reemplaza el nodo `MeshInstance3D` (el cubo azul de placeholder) con una instancia de tu modelo:
   - Arrastra el `.gltf` desde el FileSystem al nodo `Player`.
   - Ajusta el `CollisionShape3D` para que encaje con el tamaño de tu modelo.
4. Para los NPCs, repite el proceso en `NPC.tscn` o crea variantes con colores distintos usando `material_override`.

---

## Ampliaciones implementadas

- [x] Dos NPCs con movimiento autónomo y velocidades distintas
- [x] Colisión con reinicio de posición y mensaje en pantalla
- [x] Contador de intentos
- [x] Cámara en tercera persona isométrica
- [x] Iluminación y cielo procedural
- [x] Dos carriles de camino diferenciados

---

## Requisitos

- **Godot 4.3** o superior
- El Input Map ya está configurado en `project.godot` (WASD + flechas)
