extends CharacterBody3D

# ============================================================
# player.gd  —  Controla al personaje jugable
# Movimiento: WASD o flechas del teclado
# ============================================================

const SPEED    := 5.0   # Velocidad de desplazamiento
const GRAVITY  := 9.8   # Gravedad del mundo

# Posición de reaparición (se guarda al inicio)
var spawn_position : Vector3

func _ready() -> void:
	spawn_position = global_position
	add_to_group("jugador")

func _physics_process(delta: float) -> void:
	# --- Gravedad ---
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# --- Dirección desde teclado ---
	var dir := Vector3.ZERO
	dir.x = Input.get_axis("move_left", "move_right")
	dir.z = Input.get_axis("move_forward", "move_back")

	if dir != Vector3.ZERO:
		dir = dir.normalized()
		# Rotar el personaje en la dirección de movimiento
		var look_target := global_position + dir
		look_at(look_target, Vector3.UP)

	velocity.x = dir.x * SPEED
	velocity.z = dir.z * SPEED

	move_and_slide()

# Llamado desde npc.gd cuando hay colisión
func reiniciar_posicion() -> void:
	global_position = spawn_position
	velocity = Vector3.ZERO
