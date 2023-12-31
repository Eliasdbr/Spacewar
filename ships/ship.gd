class_name Ship

extends Node2D

@onready var vis_rect: Rect2 = $ScreenWrap.rect


func check_boundaries():
	var screen_size: Vector2 = get_viewport_rect().size
	var screen_top = -screen_size.y/2
	var screen_bottom = screen_top + screen_size.y
	var screen_left = -screen_size.x/2
	var screen_right = screen_left + screen_size.x
	
	# Y wrap
	if global_position.y < screen_top:
		global_position.y += screen_size.y + vis_rect.size.y/2
	if global_position.y > screen_bottom:
		global_position.y -= screen_size.y + vis_rect.size.y
	# X wrap
	if global_position.x < screen_left:
		global_position.x += screen_size.x + vis_rect.size.x/2
	if global_position.x > screen_right:
		global_position.x -= screen_size.x + vis_rect.size.x
#

func _on_screen_wrap_screen_exited():
	check_boundaries()
#
