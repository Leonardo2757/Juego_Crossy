extends Area3D

# ============================================================
# collectible.gd — Objeto coleccionable (moneda dorada)
# Señal: collected  → escuchada por Level para sumar puntos
# ============================================================

signal collected

var tiempo : float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	# Animación: rotación + flotado suave
	tiempo += delta
	rotation.y += delta * 2.0
	$MeshInstance3D.position.y = 0.5 + sin(tiempo * 2.5) * 0.12

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("jugador"):
		collected.emit()
		queue_free()
