modifier_science_progress = class({})


function modifier_science_progress:IsHidden()
	return false
end


function modifier_science_progress:DeclareFunctions()
	return { }
end


function modifier_science_progress:GetTexture()
    return "custom_folder/science_progress"
end


function modifier_science_progress:OnCreated( data )

end

function modifier_science_progress:RemoveOnDeath()
	return false
end