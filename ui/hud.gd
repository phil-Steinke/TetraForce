extends CanvasLayer

var player

const HEART_ROW_SIZE = 8
const HEART_SIZE = 8

onready var hud2d = $hud2d
onready var hearts = $hud2d/hearts
onready var buttons = $hud2d/buttons

func initialize(p):
	player = p
	player.connect("health_changed", self, "update_hearts")
	
	for i in player.MAX_HEALTH:
		var newheart = Sprite.new()
		newheart.texture = hearts.texture
		newheart.hframes = hearts.hframes
		hearts.add_child(newheart)
		update_hearts()

func update_hearts():
	for heart in hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_SIZE
		var y = (index / HEART_ROW_SIZE) * HEART_SIZE
		
		heart.position = Vector2(x,y)
		
		var lastheart = floor(player.health)
		if index > lastheart:
			heart.frame = 0
		if index == lastheart:
			heart.frame = (player.health - lastheart) * 4
		if index < lastheart:
			heart.frame = 4

func show_hearts():
	hearts.modulate = lerp(hearts.modulate, Color(1,1,1,1), 0.1)

func hide_hearts():
	hearts.modulate = lerp(hearts.modulate, Color(1,1,1,0.33), 0.2)

func show_buttons():
	buttons.modulate = lerp(buttons.modulate, Color(1,1,1,1), 0.1)

func hide_buttons():
	buttons.modulate = lerp(buttons.modulate, Color(1,1,1,0.33), 0.2)

func show_inventory():
	var inventory = preload("res://ui/inventory.tscn").instance()
	add_child(inventory)
	#inventory.start()







