extends CanvasLayer

# ============================================================
# hud.gd  —  Interfaz de usuario: mensajes y contador
# ============================================================

@onready var label_mensaje  : Label = $LabelMensaje
@onready var label_intentos : Label = $LabelIntentos

var intentos : int = 0

func _ready() -> void:
	add_to_group("hud")
	label_mensaje.visible = false
	label_intentos.text   = "Intentos: 0"

# Muestra un mensaje en pantalla durante 2 segundos
func mostrar_mensaje(texto : String) -> void:
	intentos += 1
	label_intentos.text  = "Intentos: %d" % intentos
	label_mensaje.text   = texto
	label_mensaje.visible = true
	await get_tree().create_timer(2.0).timeout
	label_mensaje.visible = false
