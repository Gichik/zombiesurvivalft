-- Generated from template

if main == nil then
	_G.main = class({})
end

require( 'main' )
require( 'timers' )

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	
	
	-----------------------------moobs-----------------------------------
	PrecacheModel("models/items/broodmother/spiderling/virulent_matriarchs_spiderling/virulent_matriarchs_spiderling.vmdl", context)
	PrecacheModel("models/heroes/undying/undying_minion.vmdl", context)
	PrecacheModel("models/heroes/life_stealer/life_stealer.vmdl", context)
	PrecacheModel("models/heroes/undying/undying_minion_torso.vmdl", context)
	PrecacheModel("models/props_debris/barrel002.vmdl", context) --trash
	PrecacheModel("models/props_debris/merchant_debris_chest001.vmdl", context) --old chest
	PrecacheModel("models/props_debris/lantern002.vmdl", context) --safe
	PrecacheModel("models/props_debris/shop_set_box001.vmdl", context) --shelf
	PrecacheModel("models/props_debris/clay_pot002.vmdl", context) --bottles
	PrecacheModel("models/props_debris/merchant_debris_chest002.vmdl", context) --chest
	PrecacheModel("models/heroes/pudge/pudge.vmdl", context)
	PrecacheModel("models/props_debris/wood_fence001g.vmdl", context) --radiation source

	PrecacheModel("models/items/pudge/gladiators_revenge_axe/gladiators_revenge_axe.vmdl", context) --radiation source	
	
	-----------------------------items-----------------------------------
	PrecacheModel("models/props_structures/wood_wall004.vmdl", context) -- wood wall
	PrecacheModel("models/heroes/axe/axe_weapon.vmdl", context) -- poleaxe
	PrecacheModel("models/heroes/juggernaut/jugg_sword.vmdl", context)  -- katana
	PrecacheModel("models/items/bounty_hunter/bounty_hunter_saw.vmdl", context) -- saw
	PrecacheModel("models/items/tidehunter/a_bit_of_boat/a_bit_of_boat.vmdl", context) -- bat
	PrecacheModel("models/props_gameplay/salve.vmdl", context) --grenade
	PrecacheModel("models/props_debris/battle_debris3.vmdl", context) -- wood
	PrecacheModel("models/props_debris/merchant_debris_book001.vmdl", context)	 -- book
	PrecacheModel("models/heroes/alchemist/alchemist_leftbottle.vmdl", context) --virus
	PrecacheModel("models/heroes/batrider/batrider_weapon.vmdl", context)	--catalyst
	PrecacheModel("models/heroes/sniper/weapon.vmdl", context) --pistol
	PrecacheModel("models/items/furion/treant/shroomling_treant/shroomling_treant.vmdl", context) --slime
	PrecacheModel("models/props_gameplay/salve_red.vmdl", context) --blood tube
	PrecacheModel("models/props_gameplay/bottle_rejuvenation.vmdl", context) --virus	
	PrecacheModel("models/props_gameplay/magic_wand.vmdl", context) --syringe
	PrecacheModel("models/items/courier/tinkbot/tinkbot.vmdl", context) --suit
	PrecacheModel("models/items/brewmaster/barrel_vice.vmdl", context)--fizzy water
	PrecacheModel("models/items/brewmaster/spiritual_spirits.vmdl", context)--food canned
	PrecacheModel("models/courier/f2p_courier/f2p_courier.vmdl", context) -- microscope
	PrecacheModel("models/heroes/kunkka/individual_board01.vmdl", context) -- bandage
	PrecacheModel("models/heroes/techies/techies_spleen_weapon.vmdl", context) --shotgun
	PrecacheModel("models/heroes/kunkka/individual_board01.vmdl", context) -- bandage
	PrecacheResource("particle", "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_anim_firebreath_c.vpcf", context)	--suit	
	PrecacheResource("particle", "models/items/rattletrap/battletrap_weapon/battletrap_weapon.vmdl", context)	--scrap
	PrecacheResource("particle", "models/props_gameplay/smoke.vmdl", context)	--antidote
	
	
	----------------------------another models-----------------------------
	PrecacheModel("models/heroes/elder_titan/ancestral_spirit.vmdl", context) --equip sute

	PrecacheModel("models/heroes/attachto_ghost/pa_gravestone_ghost.vmdl", context) -- end point model
	
		
	---------------------------------spells-------------------------------

	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context) --pistol shoot
	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf", context) --shotgun shoot
	PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf", context) --bat
	PrecacheResource("particle", "particles/units/heroes/hero_shredder/shredder_chakram.vpcf", context) --saw

	
	PrecacheResource("particle", "particles/items2_fx/soul_ring_blood.vpcf", context) -- blood then attack
	PrecacheResource("particle", "particles/generic_gameplay/generic_hit_blood.vpcf", context) --bat blood 
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood04.vpcf", context) --katana/saw blood
	PrecacheResource("particle", "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf", context) --
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", context) --pistol/shotgun blood 
	PrecacheResource("particle", "particles/generic_gameplay/generic_hit_blood.vpcf", context) -- player blood



	PrecacheResource("particle", "particles/econ/events/league_teleport_2014/teleport_end_dust_league.vpcf", context) --shotgun dust

	PrecacheResource("particle", "particles/econ/courier/courier_roshan_frost/courier_roshan_frost_ambient.vpcf", context) --development
	PrecacheResource("particle", "particles/econ/courier/courier_shagbark/courier_shagbark_firefly_big.vpcf", context) --development
	PrecacheResource("particle", "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_anim_icebreath.vpcf", context) --development
	
	PrecacheResource("particle", "particles/units/heroes/hero_pudge/pudge_loadout.vpcf", context) --pudge smoke
	PrecacheResource("particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context) --destroy wall
	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_sniper/", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_batrider/", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_juggernaut/", context)
	
	

	-------------------------------sounds--------------------------------
	PrecacheResource( "soundfile", "soundevents/zombiesurvivalft_sounds_custom.vsndevts", context )
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_brewmaster.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)

	
	local pathToIG = LoadKeyValues("scripts/items/items_game.txt") 
	PrecacheForHero("npc_dota_hero_pudge", pathToIG, context)

	
end

-- Create the game mode when we activate
function Activate()
	main:InitGameMode()
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