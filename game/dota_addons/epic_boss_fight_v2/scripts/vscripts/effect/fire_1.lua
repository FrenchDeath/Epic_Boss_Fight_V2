if lua_hero_effect_fire_1 == nil then lua_hero_effect_fire_1 = class({}) end
function lua_hero_effect_fire_1:OnCreated()
	if IsServer() then
		local hero = self:GetParent()
	end
end
function lua_hero_effect_fire_1:IsHidden()
	return false
end


function lua_hero_effect_fire_1:DeclareFunctions()
    local funcs = {
    MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end


function lua_hero_effect_fire_1:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function lua_hero_effect_fire_1:OnAttackLanded(event)
	if IsServer() then
		local hero = self:GetParent()
		if event.attacker==self:GetParent() then
			local target = event.target
			local percent = 200
			local duration = 5
			local ticktime = 0.2
			local tick = duration/ticktime
			local damage = (event.damage * (percent/100) )/tick
			local timer = 0

			local damageTable = {
				victim = target,
				attacker = hero,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			if math.random(1,100) <= 25 and target.On_Fire  ~= true then
				target.On_Fire = true
				Fire_effect = ParticleManager:CreateParticle( "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf",  PATTACH_ABSORIGIN_FOLLOW , target )
				Timers:CreateTimer(0.2, function()
					timer = timer + 0.2
					if timer <= duration then
						ApplyDamage(damageTable)
						return 0.2
					else
						target.On_Fire = nil
						ParticleManager:DestroyParticle(Fire_effect, false)
					end
			    end)
			end
		end
	end
end
