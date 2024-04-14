extends Node2D

#@onready var _shelf_item_class := preload("res://scenes/creatures/cat_food.tscn")
@onready var _score_label := $ScoreScene
@onready var _shelf := $Shelf
@onready var _pentagram := $Pentagram
@onready var _spider_cat := $SpiderCat
@onready var _mouse_cat := $MouseCat
@onready var _spider_mouse := $SpiderMouse
@onready var _demon := $Demon
@onready var _background := $GameBackground
@onready var _audio_player := $AudioStreamPlayer


@export var min_x_ratio = 0.1
@export var max_x_ratio = 0.9
@export var min_y_ratio = 0.0
@export var max_y_ratio = 1.0


func _ready():
	var summ = Global.summons
	_score_label.start()
	_spider_cat.setValues(
		Global.get_requirements_for_with(summ.SpiderCat, summ.Spider),
		Global.get_requirements_for_with(summ.SpiderCat, summ.Cat))
	_mouse_cat.setValues(
		Global.get_requirements_for_with(summ.CatMouse, summ.Mouse),
		Global.get_requirements_for_with(summ.CatMouse, summ.Cat))
	_spider_mouse.setValues(
		Global.get_requirements_for_with(summ.MouseSpider, summ.Mouse),
		Global.get_requirements_for_with(summ.MouseSpider, summ.Spider))
	_demon.setValues(
		Global.get_requirements_for_with(summ.Demon, summ.SpiderCat),
		Global.get_requirements_for_with(summ.Demon, summ.MouseSpider),
	 	Global.get_requirements_for_with(summ.Demon, summ.CatMouse))
	_spider_cat.show()
	_mouse_cat.show()
	_spider_mouse.show()
	
func _process(delta):
	check_creatures_position()

func _on_shelf_item_used(item: Variant) -> void:
	if item is CatFood:
		_pentagram.spawn_summons(Global.summons.Cat, 1)

func _on_pop_menu_item_selected(item: Variant) -> void:
	_shelf.add_item(item)
	
func check_creatures_position():
	var w = _background.get_rect().size.x
	var h = _background.get_rect().size.y
	var x0 = _background.get_rect().position.x
	var y0 = _background.get_rect().position.y
	var xLeft = x0 + min_x_ratio * w
	var xRight = x0 + max_x_ratio * w
	var yBottom = y0 + (1 - min_y_ratio) * h
	var yTop = y0 + (1 - max_y_ratio) * h
	print("y0=" + str(y0) + " h =" + str(h) + "Top = " + str(yTop) + " bottom = " + str(yBottom))
	for child in _pentagram.get_children():
		if child is Creature:
			child.position.x = clamp(child.position.x, xLeft, xRight)
			child.position.y = clamp(child.position.y, yTop, yBottom)


func _on_candle_light_off() -> void:
	# GAME OVER
	get_tree().change_scene_to_file("res://scenes/game_main.tscn")


func _on_audio_stream_player_finished() -> void:
	_audio_player.play()
