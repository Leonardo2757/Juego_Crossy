extends CharacterBody3D

# ============================================================
# npc.gd  —  NPC con movimiento autónomo de ida y vuelta (A → B)
# Detecta colisión con el jugador mediante Area3D
# ============================================================

@export var punto_a    : Vector3 = Vector3(-6.0, 0.0, 0.0)
@export var punto_b    : Vector3 = Vector3( 6.0, 0.0, 0.0)
@export var velocidad  : float   = 3.0
@export var color_material : Color = Color(1.0, 0.3, 0.3)  # Rojo por defecto

const GRAVITY := 9.8
const UMBRAL  := 0.4   # Distancia mínima para considerar que llegó al punto

var objetivo     : Vector3
var yendo_a_b    : bool = true

@onready var mesh : MeshInstance3D = $MeshInstance3D
@onready var area : Area3D         = $Area3D

func _ready() -> void:
	objetivo = punto_b
	# Aplicar color único al NPC
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color_material
	if mesh:
		mesh.material_override = mat
	# Conectar señal de colisión
	area.body_entered.connect(_on_area_body_entered)

func _physics_process(delta: float) -> void:
	# --- Gravedad ---
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# --- Movimiento hacia el objetivo ---
	var dir := objetivo - global_position
	dir.y = 0.0

	if dir.length() < UMBRAL:
		# Invertir dirección al llegar al punto
		yendo_a_b = not yendo_a_b
		objetivo   = punto_b if yendo_a_b else punto_a
	else:
		var mov := dir.normalized()
		velocity.x = mov.x * velocidad
		velocity.z = mov.z * velocidad
		look_at(global_position + mov, Vector3.UP)

	move_and_slide()

func _on_area_body_entered(body: Node3D) -> void:
	# Reaccionar solo al jugador
	if body.is_in_group("jugador"):
		body.reiniciar_posicion()
		# Notificar al HUD
		var hud := get_tree().get_first_node_in_group("hud")
		if hud:
			hud.mostrar_mensaje("¡Golpeaste un NPC! Vuelves al inicio")
