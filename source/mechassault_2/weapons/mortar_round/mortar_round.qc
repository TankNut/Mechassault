// Created by Crowbar 0.62

$modelname "mechassault_2/weapons/mortar_round.mdl"
$attachment "rocket" "bone0" 4.80 0.00 0.00 rotate -0 0 -180
$bodygroup "studio"
{
	studio "mortar_round_mech_mortarround.smd"
}


$surfaceprop "metal"

$contents "solid"

$illumposition 0.661 10.132 6.71

$cdmaterials "models\mechassault_2\weapons\"

$cbox 0 0 0 0 0 0

$bbox 0 -0.98 0 3.241 1.594 14.538

$definebone "ValveBiped.Bip01_R_Hand" "" -0.678223 13.179689 4.585938 9.999761 -89.983228 -179.811384 0 0 0 0 0 0
$definebone "bone0" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "p_stick_idle" {
	"mortar_round_anims\p_stick_idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 1
}

$collisionmodel "mortar_round_mech_mortarround.smd"
{
	$mass 10
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}
