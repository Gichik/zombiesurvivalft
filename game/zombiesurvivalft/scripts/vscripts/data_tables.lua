TABLE_MUSIC = {
	"ExtremeGhostbusters_TheCreeps",
	"HansZimmer_SamarasSong",
	"MonochromeInc_PandemicOrchestra",
	"Unknown_MysticDreamPianoMelody",
	"Myuu_HauntedByScreams",
	"NoxArcana_VeilOfDarkness",
	"RailroadWorker_TerribleLullaby",
	"Unknown_ScaryMusic",
	"Luka_ShadowHouse",
	"SlowStrings_LurkingInTheShadows",
	"SlowStrings_PandemicPrologue",
	"SlowStrings_SongOfShriekingWind",
	"Unknown_ZombieApocalypse",
	"MarilynManson_ResidentEvilMainTitleTheme"	
}


TABLE_ZOMBIE_GROWL = {
	"ZombieSurvivalFT.EffectVoiceZombie1",
	"ZombieSurvivalFT.EffectVoiceZombie2",
	"ZombieSurvivalFT.EffectVoiceZombie3",
	"ZombieSurvivalFT.EffectVoiceZombie4",
	"ZombieSurvivalFT.EffectVoiceZombie5",
	"ZombieSurvivalFT.EffectVoiceZombie6",
	"ZombieSurvivalFT.EffectVoiceZombie7",
	"ZombieSurvivalFT.EffectVoiceZombie8",
	"ZombieSurvivalFT.EffectVoiceZombie9",	
}


TABLE_RANDOM_MUSIC = {}

function GenerateTableMusic()

local i = 0

if #TABLE_RANDOM_MUSIC == 0 then
	while #TABLE_MUSIC ~= 0 and i < 1000 do
		local number = RandomInt(1,#TABLE_MUSIC)
		table.insert(TABLE_RANDOM_MUSIC,TABLE_MUSIC[number])
		table.remove(TABLE_MUSIC, number)
		i = i + 1		
	end		
end

--print("TABLE_RANDOM_MUSIC")
for _,v in pairs(TABLE_RANDOM_MUSIC) do
	--print(v)
	table.insert(TABLE_MUSIC,v)
end

--[[
print("TABLE_MUSIC")
for _,v in pairs(TABLE_MUSIC) do
	print(v)
end]]

end

TABLE_WEAPON = {
	"item_pistol",
	"item_shotgun"
}

TABLE_HEROES_SPAWN = {
	"_heroes_spawn_1",
	"_heroes_spawn_2",
	"_heroes_spawn_3",
	"_heroes_spawn_4"
}