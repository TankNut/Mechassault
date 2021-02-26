AddCSLuaFile()

ENT.WeaponTypes.Crossbow = {
	Name = "Crossbow SRM",
	Type = "Missile",
	Function = "FireCrossbow",
	Cooldown = {0.8, 1, 1.2},
	FireRate = 0.1,
	Repeats = {1, 2, 3},
	Class = {
		"ma2_proj_crossbow_lvl1",
		"ma2_proj_crossbow_lvl2",
		"ma2_proj_crossbow_lvl3"
	},
	MaxLevel = 3
}

function ENT:FireCrossbow(tbl, level, attachments)
	if SERVER then
		for i = 0, tbl.Repeats[level] - 1 do
			for k, v in ipairs(attachments) do
				local count = k + (i * #attachments)

				timer.Simple((count - 1) * tbl.FireRate, function()
					local attachment = self:GetAttachment(v)
					local ent = ents.Create(tbl.Class[level])
					local ang = (self:GetAimPos() - attachment.Pos):Angle()

					ent:SetPos(attachment.Pos)
					ent:SetAngles(ang)
					ent:SetOwner(self)
					ent.Player = self:GetPlayer()

					ent:Spawn()
					ent:Activate()
				end)
			end
		end
	end

	self:SetNextAttack(CurTime() + (tbl.Repeats[level] * #attachments * tbl.FireRate) + tbl.Cooldown[level])
end
