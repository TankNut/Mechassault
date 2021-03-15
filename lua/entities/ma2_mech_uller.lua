DEFINE_BASECLASS("ma2_mech")
AddCSLuaFile()

ENT.Base 					= "ma2_mech"

ENT.PrintName 				= "Uller"

ENT.Category 				= "MechAssault: Light Mechs"
ENT.Spawnable 				= true

ENT.Radius 					= 120
ENT.Height 					= 330

ENT.Model 					= Model("models/mechassault_2/mechs/uller.mdl")
ENT.Skin 					= 0

ENT.ViewOffset 				= Vector(-500, 0, 180)

ENT.MaxHealth 				= 2750

ENT.CoreAttachment 			= 7

ENT.WeaponLoadout = {
	{Type = "Laser", Level = 1, Attachments = {3, 4}},
	{Type = "Crossbow", Level = 1, Attachments = {5, 6}}
}

ENT.JumpJets 				= {7, 8, 9}

function ENT:GetAnimationSpeeds()
	return 240, 540
end

function ENT:GetSpeeds()
	return 400, 822
end
