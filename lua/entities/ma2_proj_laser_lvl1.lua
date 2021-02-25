DEFINE_BASECLASS("ma2_proj")
AddCSLuaFile()

ENT.Base 					= "ma2_proj"

ENT.Damage 					= 65
ENT.Velocity 				= 6000
ENT.HullSize 				= 10

ENT.ParticleAttach 			= "gm_MA2_laser_lvl1"

ENT.ImpactSound 			= Sound("mechassault_2/weapons/laser_impact_mech.ogg")
ENT.FireSound 				= Sound("mechassault_2/weapons/laser_lvl1.ogg")

PrecacheParticleSystem("gm_MA2_laser_lvl1")

function ENT:Initialize()
	BaseClass.Initialize(self)

	self:DrawShadow(false)
end

if CLIENT then
	function ENT:Draw()
	end
end