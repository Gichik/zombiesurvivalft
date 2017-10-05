kitchen_transmute = class({})

function KitchenTransmute(data)
    local caster = data.caster
    if caster:HasItemInInventory("item_food_canned") then
        CreateRareFood(data)
    end

end


function CreateRareFood(data)
    local caster = data.caster
    local itemName = "item_food_canned"
    local item = nil
    local charges = 0
    local first = 0
    local recipeChecked = true
    for i = 0, 8 do
        item = caster:GetItemInSlot(i)
        if item ~= nil then
            if item:GetAbilityName() == itemName then
                if item:IsStackable() == true then
                    if item:GetCurrentCharges() > 1 then
                        charges = item:GetCurrentCharges()
                        item:SetCurrentCharges(charges-1)
                        caster:DropItemAtPositionImmediate(item,caster:GetAbsOrigin())
                        item:LaunchLoot(false, 300, 0.75, caster:GetAbsOrigin() + RandomVector(200))
                    else
                        caster:RemoveItem(item)
                    end
                else
                    caster:RemoveItem(item)        
                end
            end
        end
    end 

    if recipeChecked then
        test_map:CreateDrop("item_sleeping_tablet", caster:GetAbsOrigin())
    end
end