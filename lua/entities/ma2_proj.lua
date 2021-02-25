AddCSLuaFile()

ENT.Type 					= "anim"
ENT.AutomaticFrameAdvance	= true

ENT.Author 					= "TankNut"

ENT.Model 					= Model("models/weapons/w_missile_launch.mdl")

ENT.Damage 					= 0

ENT.Velocity 				= 3000
ENT.HullSize 				= 10

ENT.GravityMultiplier 		= 0

ENT.AngOffset 				= Angle()

function ENT:Initialize()
	self:SetModel(self.Model)

	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

	self:SetVel(self:GetForward() * self.Velocity)
	self.LastThink = CurTime()

	self.Hit = false

	if self.ParticleAttach then
		ParticleEffectAttach(self.ParticleAttach, PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end

	if self.FireSound then
		self:EmitSound(self.FireSound)
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Vector", 0, "Vel")
end

function ENT:Think()
	if self.Hit then
		return
	end

	local gravity = physenv.GetGravity() * self.GravityMultiplier
	local delta = CurTime() - self.LastThink

	self:SetVel(self:GetVel() + (gravity * delta))
	self:Process(delta)

	local pos = self:GetPos() + (self:GetVel() * delta)

	local blacklist = {
		[self] = true,
		[self:GetOwner()] = true,
		["phys_bone_follower"] = true
	}

	local tr = util.TraceHull({
		start = self:GetPos(),
		endpos = pos,
		filter = function(ent)
			if blacklist[ent] or blacklist[ent:GetClass()] or ent:GetClass() == self:GetClass() then
				return false
			end

			return true
		end,
		collisiongroup = COLLISION_GROUP_PROJECTILE,
		mins = Vector(-0.5, -0.5, -0.5) * self.HullSize,
		maxs = Vector(0.5, 0.5, 0.5) * self.HullSize
	})

	if tr.Fraction != 1 then
		self:OnHit(tr)
		self:SetPos(tr.HitPos)

		self.Hit = true

		if CLIENT then
			self:StopParticleEmission()
		else
			SafeRemoveEntityDelayed(self, 1)
		end

		return
	end

	local ang = self:GetVel():Angle() + self.AngOffset

	if CLIENT then
		self:SetRenderOrigin(pos)
		self:SetRenderAngles(ang)
	else
		self:SetPos(pos)
		self:SetAngles(ang)
	end

	self.LastThink = CurTime()
	self:NextThink(CurTime())

	return true
end

function ENT:Process()
end

if SERVER then
	function ENT:DealDamage(ent)
		local mech = self:GetOwner()

		if IsValid(mech) and IsValid(self.Player) then
			local dmg = DamageInfo()

			dmg:SetDamageType(DMG_DIRECT)
			dmg:SetInflictor(mech)
			dmg:SetAttacker(self.Player)
			dmg:SetDamage(self.Damage)
			dmg:SetDamagePosition(self:GetPos())

			ent:TakeDamageInfo(dmg)
		end
	end
end

function ENT:OnHit(tr)
	if self.ImpactSound then
		self:EmitSound(self.ImpactSound)
	end

	if SERVER and IsValid(tr.Entity) then
		self:DealDamage(tr.Entity)
	end
end