AddCSLuaFile()

ENT.WeaponTypes.Javelin = {
	Name = "Javelin LRM",
	Type = "Missile",
	Function = "FireJavelin",
	Cooldown = 2.5,
	FireRate = 0.1,
	Class = {
		"ma2_proj_javelin_lvl1",
		"ma2_proj_javelin_lvl2",
		"ma2_proj_javelin_lvl3"
	},
	MaxLevel = 3
}

function ENT:FireJavelin(tbl, level, attachments)
	if SERVER then
		local target = self:GetTargetLock() -- Cache early so we re-use the same target in the timer section

		for k, v in ipairs(attachments) do
			timer.Simple((k - 1) * tbl.FireRate, function()
				local attachment = self:GetAttachment(v)
				local ent = ents.Create(tbl.Class[level])

				ent:SetPos(attachment.Pos)
				ent:SetAngles(attachment.Ang)
				ent:SetOwner(self)
				ent.Player = self:GetPlayer()

				ent:Spawn()
				ent:Activate()

				if IsValid(target) then
					ent:SetTracked(target)
				else
					ent:SetTargetPos(self:GetAimTrace().HitPos)
				end
			end)
		end
	end

	self:SetNextAttack(CurTime() + (#attachments * tbl.FireRate) + tbl.Cooldown)
end
