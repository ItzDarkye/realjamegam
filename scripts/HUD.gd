extends CanvasLayer

@onready var player = $health
@onready var bar = $ImmortalBar

func _ready() -> void:
	player.health_changed.connect(heart_hud)
	player.died.connect(hud_flash)
	heart_hud(player.current_health, player.max_health)
	bar.time_to_notimm.connect(hud_flash)


func heart_hud(current_health: int, max_health: int) -> void:
	$Panel/Heart.size.x = 16 * current_health


func hud_flash() -> void:
	while not player.is_alive:
		$Panel.modulate = Color(1, 0, 0, 1)
		await get_tree().create_timer(0.35).timeout
		$Panel.modulate = Color(1, 1, 1, 1)
		await get_tree().create_timer(0.35).timeout


		
