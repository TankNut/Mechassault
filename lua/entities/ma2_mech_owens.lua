DEFINE_BASECLASS("ma2_mech")
AddCSLuaFile()

ENT.Base 					= "ma2_mech"

ENT.PrintName 				= "Owens"

ENT.Category 				= "MechAssault: Light Mechs"
ENT.Spawnable 				= true

ENT.Radius 					= 120
ENT.Height 					= 320

ENT.Model 					= Model("models/mechassault_2/mechs/owens.mdl")
ENT.Skin 					= 0

ENT.ViewOffset 				= Vector(-500, 0, 180)

ENT.MaxHealth 				= 2946

ENT.CoreAttachment 			= 6

ENT.WeaponLoadout = {
	{Type = "Machinegun", Level = 1, Attachments = {2, 3}},
	{Type = "Crossbow", Level = 1, Attachments = {4, 5}}
}

function ENT:GetAnimationSpeeds()
	return 350, 580
end

function ENT:GetSpeeds()
	return 400, 1050
end
