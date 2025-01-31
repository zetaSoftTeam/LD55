extends Node

signal summon_creature;

func _ready():
	$upgradeCatMouse.transform.connect(spawnTransformation.bind(Global.summons.CatMouse))
	$upgradeSpiderMouse.transform.connect(spawnTransformation.bind(Global.summons.MouseSpider))
	$upgradeSpiderCat.transform.connect(spawnTransformation.bind(Global.summons.SpiderCat))
	$upgradeDemon.transform.connect(spawnTransformation.bind(Global.summons.Demon))
	
func setValues(SpiderForSpiderCat, CatForSpiderCat, MouseForCatMouse, CatForCatMouse, MouseForMouseSpider, SpiderForMouseSpider, _SpiderCatForDemon, _MouseSpiderForDemon, _CatMouseForDemon):
	$nb_spider_for_spidercat.text = str(SpiderForSpiderCat)
	$nb_cat_for_spidercat.text = str(CatForSpiderCat)
	$nb_mouse_for_catmouse.text = str(MouseForCatMouse)
	$nb_cat_for_catmouse.text = str(CatForCatMouse)
	$nb_mouse_for_spidermouse.text = str(MouseForMouseSpider)
	$nb_spider_for_spidermouse.text = str(SpiderForMouseSpider)
	
func spawnTransformation(type):
	match type:
		Global.summons.CatMouse:
			summon_creature.emit(Global.summons.CatMouse, 1);
		Global.summons.MouseSpider:
			summon_creature.emit(Global.summons.MouseSpider, 1);
		Global.summons.SpiderCat:
			summon_creature.emit(Global.summons.SpiderCat, 1);
		Global.summons.Demon:
			summon_creature.emit(Global.summons.Demon, 1);

func update_upgradeAvailable(creature, creatureAvailable):
	if (creature == Global.summons.SpiderCat):
		$upgradeSpiderCat.set_visible(creatureAvailable[Global.summons.SpiderCat])
		$glowSpiderCat.set_visible(creatureAvailable[Global.summons.SpiderCat])
		$glowSpider_SpiderCat.set_visible(creatureAvailable[Global.summons.Spider])
		$glowCat_SpiderCat.set_visible(creatureAvailable[Global.summons.Cat])
	elif (creature == Global.summons.MouseSpider):
		$upgradeSpiderMouse.set_visible(creatureAvailable[Global.summons.MouseSpider])
		$glowSpiderMouse.set_visible(creatureAvailable[Global.summons.MouseSpider])
		$glowSpider_SpiderMouse.set_visible(creatureAvailable[Global.summons.Spider])
		$glowMouse_SpiderMouse.set_visible(creatureAvailable[Global.summons.Mouse])
	elif (creature == Global.summons.CatMouse):
		$upgradeCatMouse.set_visible(creatureAvailable[Global.summons.CatMouse])
		$glowCatMouse.set_visible(creatureAvailable[Global.summons.CatMouse])
		$glowMouse_CatMouse.set_visible(creatureAvailable[Global.summons.Mouse])
		$glowCat_CatMouse.set_visible(creatureAvailable[Global.summons.Cat])
	elif (creature == Global.summons.Demon):
		$upgradeDemon.set_visible(creatureAvailable[Global.summons.Demon])
		$glowDemon.set_visible(creatureAvailable[Global.summons.Demon])
