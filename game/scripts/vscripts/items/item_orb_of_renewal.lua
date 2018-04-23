item_orb_of_renewal = class({})
LinkLuaModifier( "modifier_item_orb_of_renewal_passive", "items/item_orb_of_renewal.lua" ,LUA_MODIFIER_MOTION_NONE )

function item_orb_of_renewal:GetIntrinsicModifierName()
	return "modifier_item_orb_of_renewal_passive"
end

modifier_item_orb_of_renewal_passive = class({})

function modifier_item_orb_of_renewal_passive:OnCreated()
	self.reduction = self:GetSpecialValueFor("ult_chance")
end

function modifier_item_orb_of_renewal_passive:DeclareFunctions()
	return {MODIFIER_EVENT_ON_ABILITY_FULLY_CAST}
end

function modifier_item_orb_of_renewal_passive:GetModifierPercentageCooldownStacking(params)
	return self.cdr
end

function modifier_item_orb_of_renewal_passive:OnAbilityFullyCast(params)
	if params.ability and params.ability:GetCooldown(-1) > 0.5 and params.unit == self:GetParent() then
		for i = 0, self:GetParent():GetAbilityCount() - 1 do
			local ability = self:GetParent():GetAbilityByIndex( i )
			if ability then
				ability:ModifyCooldown(self.reduction)
			end
		end
		if bItems then
			for i=0, 5, 1 do
				local current_item = self:GetParent():GetItemInSlot(i)
				if current_item ~= nil and current_item ~= item then
					current_item:ModifyCooldown(self.reduction)
				end
			end
		end
	end
end

function modifier_item_orb_of_renewal_passive:IsHidden()
	return true
end