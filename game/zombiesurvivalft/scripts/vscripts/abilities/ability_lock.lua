ability_lock = class({})

function ability_lock:OnSpellStart()
--print("ability_lock")
	ShowGenericPopupToPlayer( self:GetCaster():GetPlayerOwner(), "#popup_title_lock", "#popup_body_lock", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end