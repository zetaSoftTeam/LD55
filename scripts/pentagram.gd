extends Node


@onready var _cat_class := preload("res://scenes/creatures/cat.tscn")

@onready var _background_sprite := $Background

var summons_container = {}

#signal chimera_available()

func _ready():
	#TODO : doute ici sur le .values() du enum...
	for type in Global.summons.values():
		summons_container[type] = []
	spawn_summons(Global.summons.Cat, 1)
	spawn_summons(Global.summons.Spider, 1)
	
# Spawn a given numbers of summons of selected type
# Returns true if successful
func spawn_summons(type : Global.summons, count : int) -> bool:
	var ret = true
	for i in range(count):
		ret = ret and _spawn_one_summon(type)
	check_chimera_availability()
	return ret
		
# Spawn one summon of a given type
# Returns true if successful
func _spawn_one_summon(type : Global.summons) -> bool:
	#HELP Jean-François ! 
	#Je ne sais pas pourquoi mais cette ligne ne fonctionne plus
	#Je pense qu'il caste en int ou je ne sais quoi....
	#Pour infos cette ligne etait good avant que je passe le enum summons dans global...
	#si t'as une idée...
	#if type in summons_container.keys():
	#	var new_summon = Creature.new()
	#	summons_container[type].append(new_summon)
	#	add_child(new_summon)
	#	print("Grrr")
	#	return true
	#else:
	#	print("plouf")
	#	return false	
	#if type in Global.summons:
	match type:
		Global.summons.Cat:
			var new_summon = _cat_class.instantiate()
			var _width : int = _background_sprite.texture.get_width()
			var _height : int = _background_sprite.texture.get_height()
			
			new_summon.position.x = randi_range(-int(_width/2.0), int(_width/2.0))
			new_summon.position.y = randi_range(-int(_height/2.0), int(_height/2.0))
			summons_container[type].append(new_summon)
			add_child(new_summon)
			print("Grrr")
			return true
		Global.summons.Cat:
			return true
		Global.summons.Spider:
			return true
		Global.summons.Mouse:
			return true
		Global.summons.SpiderCat:
			return true
		Global.summons.CatMouse:
			return true
		Global.summons.MouseSpider:
			return true
		Global.summons.Demon:
			return true
	return false

# Destroy a given number of summons of given type
# Returns true if successful
func destroy_summons(type, count) -> bool:
	var ret = true;
	if get_number_of_summons(type) < count :
		return false
	for i in range(0, count):
		ret = ret and _destroy_one_summon(type)
	check_chimera_availability()
	return ret	

# Destroy one summon of given type
# Returns true if successful		
func _destroy_one_summon(type) -> bool:
	#TODO : kill a random instead of oldest ?
	if type in Global.summons and summons_container[type].size() > 0:
		var to_kill = summons_container[type][0]
		remove_child(to_kill)
		summons_container[type].erase(to_kill)
		print("Ded")
		return true
	print("not ded")
	return false

#Returns the number of summons of a given type
func get_number_of_summons(type) -> int:
	if (type in summons_container.keys()):
		return summons_container[type].size()
	return 0
	
# Returns the total number of all summons
func get_number_of_all_summons() -> int:
	var ret := 0 
	for type in Global.summons:
		ret += get_number_of_summons(type)
	return ret
	
func check_chimera_availability():
	#TODO : FIXME
	for chimera in Global.summons_requirements.keys():
		var is_available = true
		for creature in Global.summons_requirements[chimera].keys():	
			var count = get_number_of_summons(creature)
			var enough_creature = count >= Global.summons_requirements[chimera][creature]
			is_available = is_available and enough_creature
		#remove error TODO
		#emit_signal("chimera_available", chimera, is_available)	

func create_chimera(_type : Global.summons, _count : int) -> bool:
	return true
