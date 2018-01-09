-- Generated from template


require( 'main' )
require( 'test_map' )
require( 'somewill_map' )
require( 'timers' )
require( 'data_tables' )

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	
	
	-----------------------------moobs-----------------------------------
	PrecacheModel("models/props_debris/barrel002.vmdl", context) --trash
	PrecacheModel("models/heroes/juggernaut/jugg_healing_ward.vmdl", context) --campfire
	PrecacheModel("models/props_debris/camp_fire001.vmdl", context) --campfire
	PrecacheModel("models/heroes/life_stealer/life_stealer.vmdl", context) --mutant
	PrecacheModel("models/heroes/undying/undying_minion.vmdl", context) --zombie
	PrecacheModel("models/props_foliage/tree_pine01.vmdl", context) --npc_thirst

	PrecacheModel("models/props_stone/stone_column004a.vmdl", context) --npc_kitchen_table
	PrecacheModel("models/props_debris/merchant_debris_chest002.vmdl", context) --npc_kitchen_table
	
	PrecacheModel("models/items/rattletrap/warmachine_cog_dc/warmachine_cog_dc.vmdl", context) --npc_generator
	PrecacheModel("models/heroes/tinker/mom.vmdl", context) --npc_scientific_table
	
	-----------------------------items-----------------------------------
	PrecacheModel("models/props_structures/wood_wall004.vmdl", context) -- wood wall
	PrecacheModel("models/props_debris/battle_debris3.vmdl", context) -- wood wall
	PrecacheModel("models/props_gameplay/tombstonea01.vmdl", context) --rip
	PrecacheModel("models/creeps/dead_creeps/dire_creep_melee_dead_01.vmdl", context) --rip



	-----------------------------particle-----------------------------------
	PrecacheResource("particle", "particles/generic_gameplay/generic_sleep.vpcf", context)	--sleep
	PrecacheResource("particle", "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_ward_flame.vpcf", context) --campfire
	PrecacheResource("particle", "particles/dev/library/base_fire.vpcf", context) --campfire	
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood04.vpcf", context) --blood	


	---------------------------------spells-------------------------------

	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context) --pistol shoot
	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf", context) --shotgun shoot
	PrecacheResource("particle", "particles/econ/events/league_teleport_2014/teleport_end_dust_league.vpcf", context) --shotgun dust
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf", context) --bat

	
	PrecacheResource("particle", "particles/items2_fx/soul_ring_blood.vpcf", context) -- blood then attack
	PrecacheResource("particle", "particles/generic_gameplay/generic_hit_blood.vpcf", context) --bat blood 
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood04.vpcf", context) --katana/saw blood
	PrecacheResource("particle", "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf", context) --
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", context) --pistol/shotgun blood 
	PrecacheResource("particle", "particles/generic_gameplay/generic_hit_blood.vpcf", context) -- player blood

	PrecacheResource("particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context) --destroy wall
	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_sniper/", context)
	--PrecacheResource("particle_folder", "particles/units/heroes/hero_batrider/", context)
	--PrecacheResource("particle_folder", "particles/units/heroes/hero_juggernaut/", context)
	
	

	-------------------------------sounds--------------------------------
	PrecacheResource("soundfile", "soundevents/zombiesurvivalft_sounds_custom.vsndevts", context )
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context)
	--PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts", context)
	--PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
	--PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context)
	--PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context)
	--PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	--PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_brewmaster.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)

	
	local pathToIG = LoadKeyValues("scripts/items/items_game.txt") 
	--PrecacheForHero("npc_dota_hero_pudge", pathToIG, context)

	
end

-- Create the game mode when we activate
function Activate()

	local MapName = GetMapName()
	print(MapName)

	if MapName == "random_map" then
		print("----------------------------------------Random map Start----------------------------------------")
		main:InitGameMode()
	end

	if MapName == "test" then
		print("----------------------------------------Test map Start----------------------------------------")	
		test_map:InitGameMode()
	end

	if MapName == "somewill_map" then
		print("----------------------------------------Test map Start----------------------------------------")
		somewill_map:InitGameMode()
	end
	
end



function IsForHero(str, tbl)
	if type(tbl["used_by_heroes"]) ~= type(1) and tbl["used_by_heroes"] then -- привет от вашего друга, индийского быдлокодера работающего за еду
		if tbl["used_by_heroes"][str] then
			return true
		end
	end
	return false
end

function PrecacheForHero(name,path,context)

	print('[PrecacheHero] Start')
print("----------------------------------------Precache Start----------------------------------------")

	local wearablesList = {} --переменная для надеваемых шмоток(для всех героев)
	local precacheWearables = {} --переменная только для шмоток нужного героя
	local precacheParticle = {}
	for k, v in pairs(path) do
		if k == 'items' then
			wearablesList = v
		end
	end
	local counter = 0
	local counter_particle = 0
	local value
	for k, v in pairs(wearablesList) do -- выбираем из списка предметов только предметы на нужных героев
		if IsForHero(name, wearablesList[k]) then
			if wearablesList[k]["model_player"] then
				value = wearablesList[k]["model_player"] 
				precacheWearables[value] = true
			end
			if wearablesList[k]["particle_file"] then -- прекешируем еще и частицы, куда ж без них!
				value = wearablesList[k]["particle_file"] 
				precacheParticle[value] = true
			end
		end
	end

	for wearable,_ in pairs( precacheWearables ) do --собственно само прекеширование всех занесенных в список шмоток
		print("Precache model: " .. wearable)
		PrecacheResource( "model", wearable, context )
		counter = counter + 1
	end

	for wearable,_ in pairs( precacheParticle) do --и прекеширование частиц
		print("Precache particle: " .. wearable)
		PrecacheResource( "particle", wearable, context )
		counter_particle = counter_particle + 1

	end

	PrecacheUnitByNameSync(name, context) -- прекешируем саму модель героя! иначе будут бегать шмотки без тела
		
    print('[Precache]' .. counter .. " models loaded and " .. counter_particle .." particles loaded")
	print('[Precache] End')

end