class PGAssets extends Actor;
//Defaults

//#exec OBJ LOAD FILE=CoreTexWood
//#exec obj load file=..\Textures\CoreTexStone.utx package=CoreTexStone
#exec obj load file=..\Textures\Extras.utx package=Extras
#exec obj load file=..\Textures\CoreTexEarth.utx package=CoreTexEarth
#exec obj load file=..\Textures\CoreTexMetal.utx package=CoreTexMetal
#exec obj load file=..\Textures\CoreTexGlass.utx package=CoreTexGlass

//Bed
#exec mesh import mesh=bedsmall anivfile=Models\bedsmall_a.3d datafile=Models\bedsmall_d.3d x=0 y=0 z=0
#exec mesh origin mesh=bedsmall x=0 y=0 z=0
#exec mesh sequence mesh=bedsmall seq=All startframe=0 numframes=1

#exec meshmap new meshmap=bedsmall mesh=bedsmall
#exec meshmap scale meshmap=bedsmall x=1 y=1 z=1

#exec obj load file=..\Textures\Effects.utx package=Effects

// FLBasketball.
#exec MESH IMPORT MESH=FLBasketball ANIVFILE=Models\FLBasketball_a.3d DATAFILE=Models\FLBasketball_d.3d X=0 Y=0 Z=0
#exec MESH ORIGIN MESH=FLBasketball X=0 Y=0 Z=0
#exec MESH SEQUENCE MESH=FLBasketball SEQ=All STARTFRAME=0 NUMFRAMES=1
#exec MESHMAP NEW MESHMAP=FLBasketball MESH=FLBasketball
#exec MESHMAP SCALE MESHMAP=FLBasketball X=0.122135 Y=0.122135 Z=0.122135
#exec TEXTURE IMPORT NAME=FLBasketball FILE=Textures\FLBasketball.pcx GROUP="Skins" 
#exec MESHMAP SETTEXTURE MESHMAP=FLBasketball NUM=0 TEXTURE=FLBasketball
#exec MESHMAP SETTEXTURE MESHMAP=FLBasketball NUM=1 TEXTURE=FLBasketball

#exec AUDIO IMPORT FILE="Sounds\Bounce1.wav" NAME="Bounce1" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\Bounce2.wav" NAME="Bounce2" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\Bounce3.wav" NAME="Bounce3" GROUP="Generic"

//#exec AUDIO IMPORT FILE="Sounds\gready.wav" NAME="gready" GROUP="Generic"
//#exec AUDIO IMPORT FILE="Sounds\gfire.wav" NAME="gfire" GROUP="Generic"
//#exec AUDIO IMPORT FILE="Sounds\greload.wav" NAME="greload" GROUP="Generic"

//Automed
#exec AUDIO IMPORT FILE="Sounds\automedic_on.wav" NAME="automedic_on" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\blood_toxins.wav" NAME="blood_toxins" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\heat_damage.wav" NAME="heat_damage" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\major_fracture.wav" NAME="major_fracture" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\near_death.wav" NAME="near_death" GROUP="Generic"

#exec TEXTURE IMPORT NAME="iMed" FILE="Textures\iMed.bmp" GROUP="Skins"
#exec TEXTURE IMPORT NAME="acrate" FILE="Textures\acrate.bmp" GROUP="Skins"
#exec TEXTURE IMPORT NAME="Hellhound" FILE="Textures\HellhoundTex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CuteBot3" FILE="Textures\CuteBot3.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="DildoTex1" FILE="Textures\DildoTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="gblue" FILE="Textures\gblue.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="gdefault" FILE="Textures\gdefault.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="gpink" FILE="Textures\gpink.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="gred" FILE="Textures\gred.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="gyellow" FILE="Textures\gyellow.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="KaiTex2" FILE="Textures\KaiTex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="PartyBox" FILE="Textures\PartyBox.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SOLTex1" FILE="Textures\SOLTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SOLTex2" FILE="Textures\SOLTex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SOLTex3" FILE="Textures\SOLTex3.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="NailTex" FILE="Textures\NailDartTex0.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="NailTex2" FILE="Textures\NailGunDartTex3.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="NailTex3" FILE="Textures\NailGunDartTex4.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="NailTex4" FILE="Textures\NailGunDartTex5.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex0White" FILE="Textures\HeartTex0White.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex1Blue" FILE="Textures\HeartTex1Blue.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex2Pink1" FILE="Textures\HeartTex2Pink1.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex3Pink2" FILE="Textures\HeartTex3Pink2.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex4REd" FILE="Textures\HeartTex4REd.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex5Yellow" FILE="Textures\HeartTex5Yellow.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex6green" FILE="Textures\HeartTex6green.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="HeartTex7purple" FILE="Textures\HeartTex7purple.pcx" GROUP="Skins" FLAGS=3
#exec TEXTURE IMPORT NAME="IceTex" FILE="Textures\IceTex.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="YellowRay" FILE="Textures\YellowRay.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SkyBlueRay" FILE="Textures\SkyBlueRay.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="BlueRay" FILE="Textures\BlueRay.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="wKai1" FILE="Textures\wKai1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="wKai2" FILE="Textures\wKai2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="karkianskel" FILE="Textures\karkianskel.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="junker" FILE="Textures\junker.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="bonerTex1" FILE="Textures\bonerTex1.pcx" 
#exec TEXTURE IMPORT NAME="boner3rdTex1" FILE="Textures\boner3rdTex1.pcx"
#exec TEXTURE IMPORT NAME="KaiAlt2Tex2" FILE="Textures\KaiAlt2Tex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="KaiAlt2Tex3" FILE="Textures\KaiAlt2Tex3.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="flagpoletex6" FILE="Textures\flagpoletex6.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="flagpoletex7" FILE="Textures\flagpoletex7.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="flagpoletex8" FILE="Textures\flagpoletex8.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="flagpoletex9" FILE="Textures\flagpoletex9.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SatanTex1" FILE="Textures\SatanTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SatanTex2" FILE="Textures\SatanTex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SoldierSRJTex" FILE="Textures\SoldierSRJTex.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="Carlos1Tex1" FILE="Textures\Carlos1Tex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SovietTex0" FILE="Textures\SovietTex0.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SovietTex1" FILE="Textures\SovietTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="SovietTex2" FILE="Textures\SovietTex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="wkai3" FILE="Textures\wkai3.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="MIBTex17" FILE="Textures\MIBTex17.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="BlackTex1" FILE="Textures\BlackTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTSwatTex2" FILE="Textures\CTSwatTroopTex2.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTSwatTex1" FILE="Textures\SWATHelmetTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="wtf" FILE="Textures\wtf.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTGruntTex1" FILE="Textures\GruntPantsGreenTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTGruntTex2" FILE="Textures\CTGruntVestTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTExecTex1" FILE="Textures\CTExecSuitTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTEnforcerGuardTex1" FILE="Textures\CTEnforcerGuardTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTEliteArmourTex1" FILE="Textures\CTEliteArmourTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CTEliteHelmetTex1" FILE="Textures\CTEliteHelmetTex1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="PageChurchSwordTex1" FILE="Textures\PageChurchSwordTex1.pcx" GROUP="Skins"

#exec TEXTURE IMPORT NAME="CMB0" FILE="Textures\CMB0.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="CMB1" FILE="Textures\CMB1.pcx" GROUP="Skins"
#exec TEXTURE IMPORT NAME="AgentPussy" FILE="Textures\AgentPussy.pcx" GROUP="Skins"

#exec AUDIO IMPORT FILE="Sounds\emergencylove.wav" NAME="emergencylove" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\Authorizing.wav" NAME="Auth" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\FindingConnection.wav" NAME="Find" GROUP="Generic"
#exec AUDIO IMPORT FILE="Sounds\SendingSignal.wav" NAME="Send" GROUP="Generic"

#exec TEXTURE IMPORT NAME=LargeSGAssaultIcon FILE=Textures\LargeSGAssaultIcon.pcx GROUP=Icons FLAGS=2
#exec TEXTURE IMPORT NAME=BeltIconSGAssault FILE=Textures\BeltIconSGAssault.pcx GROUP=Icons FLAGS=2

#exec TEXTURE IMPORT NAME=LargeEstusIcon FILE=Textures\LargeEstusIcon.pcx GROUP=Icons FLAGS=2
#exec TEXTURE IMPORT NAME=BeltIconEstus FILE=Textures\BeltIconEstus.pcx GROUP=Icons FLAGS=2
#exec TEXTURE IMPORT NAME=BeltIconCrafting FILE=Textures\BeltIconCrafting.pcx GROUP=Icons FLAGS=2
#exec TEXTURE IMPORT NAME=BeltIconCraftingFlask FILE=Textures\BeltIconCraftingFlask.pcx GROUP=Icons FLAGS=2
#exec OBJ LOAD FILE=Effects
#exec OBJ LOAD FILE=DeusExItems
#exec obj load FILE=Ambient

#exec texture IMPORT NAME=pinkmasktex FILE=Textures\BlackMaskTex.pcx GROUP=Skins FLAGS=2

//=============================================================================
// BRAssaultGun
//=============================================================================

#exec texture IMPORT NAME=HDTPMuzzleflashlarge1 FILE=Textures\Muzz1.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge2 FILE=Textures\Muzz2.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge3 FILE=Textures\Muzz3.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge4 FILE=Textures\Muzz4.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge5 FILE=Textures\Muzz5.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge6 FILE=Textures\Muzz6.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge7 FILE=Textures\Muzz7.pcx GROUP=Skins FLAGS=2
#exec texture IMPORT NAME=HDTPMuzzleflashlarge8 FILE=Textures\Muzz8.pcx GROUP=Skins FLAGS=2
//
// BRAssaultGun
//	+Z down
//	-Y forward
//	+X right
// player view version
#exec MESH IMPORT MESH=BRAssaultGun ANIVFILE=MODELS\WEAP_x7PR_pov_a.3d DATAFILE=MODELS\WEAP_x7PR_pov_d.3d
#exec MESH LODPARAMS MESH=BRAssaultGun STRENGTH=0
#exec MESH ORIGIN MESH=BRAssaultGun X=0 Y=0 Z=0 YAW=-60
#exec MESHMAP SCALE MESHMAP=BRAssaultGun X=0.00390625 Y=0.00390625 Z=0.00390625
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=All			STARTFRAME=0	NUMFRAMES=61
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Still		STARTFRAME=0	NUMFRAMES=1
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Select		STARTFRAME=1	NUMFRAMES=8		RATE=18	GROUP=Select
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Shoot		STARTFRAME=9	NUMFRAMES=8		RATE=18
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=ReloadBegin	STARTFRAME=17	NUMFRAMES=5		RATE=10
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Reload		STARTFRAME=22	NUMFRAMES=7		RATE=5
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=ReloadEnd	STARTFRAME=29	NUMFRAMES=3		RATE=10
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Down		STARTFRAME=32	NUMFRAMES=5		RATE=10
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Idle1		STARTFRAME=37	NUMFRAMES=8		RATE=2
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Idle2		STARTFRAME=45	NUMFRAMES=8		RATE=2
#exec MESH SEQUENCE MESH=BRAssaultGun SEQ=Idle3		STARTFRAME=53	NUMFRAMES=8		RATE=2

#exec TEXTURE IMPORT NAME=BRAssaultGunTex1 FILE=textures\X7PR2.pcx GROUP=Skins
#exec TEXTURE IMPORT NAME=BRAssaultGunTex2 FILE=textures\display1.pcx GROUP=Skins

#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun NUM=0 TEXTURE=DeusExItems.Skins.WeaponHandsTex
#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun NUM=1 TEXTURE=DeusExItems.Skins.WeaponHandsTex
#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun NUM=2 TEXTURE=pinkmasktex
#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun NUM=3 TEXTURE=BRAssaultGunTex1
#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun NUM=4 TEXTURE=BRAssaultGunTex2

#exec MESH NOTIFY MESH=BRAssaultGun SEQ=Shoot	TIME=0.05	FUNCTION=SwapMuzzleFlashTexture
#exec MESH NOTIFY MESH=BRAssaultGun SEQ=Shoot	TIME=0.25	FUNCTION=SwapMuzzleFlashTexture
#exec MESH NOTIFY MESH=BRAssaultGun SEQ=Shoot	TIME=0.45	FUNCTION=SwapMuzzleFlashTexture
#exec MESH NOTIFY MESH=BRAssaultGun SEQ=Shoot	TIME=0.65	FUNCTION=SwapMuzzleFlashTexture
#exec MESH NOTIFY MESH=BRAssaultGun SEQ=Shoot	TIME=0.85	FUNCTION=SwapMuzzleFlashTexture

// 3rd person version
#exec MESH IMPORT MESH=BRAssaultGun3rd ANIVFILE=Models\WEAP_x7pr_3rd_a.3d DATAFILE=Models\WEAP_x7pr_3rd_d.3d
#exec MESH LODPARAMS MESH=BRAssaultGun3rd STRENGTH=0
#exec MESH ORIGIN MESH=BRAssaultGun3rd X=0 Y=0 Z=0
#exec MESHMAP SCALE MESHMAP=BRAssaultGun3rd X=0.00390625 Y=0.00390625 Z=0.00390625
#exec MESH SEQUENCE MESH=BRAssaultGun3rd SEQ=All		STARTFRAME=0	NUMFRAMES=1
#exec MESH SEQUENCE MESH=BRAssaultGun3rd SEQ=Still	STARTFRAME=0	NUMFRAMES=1

#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun3rd NUM=0 TEXTURE=BRAssaultGunTex1
#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun3rd NUM=1 TEXTURE=BRAssaultGunTex1
#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGun3rd NUM=2 TEXTURE=pinkmasktex

// pickup version
#exec MESH IMPORT MESH=BRAssaultGunPickup ANIVFILE=Models\WEAP_x7pr_pickup_a.3d DATAFILE=Models\WEAP_x7pr_pickup_d.3d
#exec MESH LODPARAMS MESH=BRAssaultGunPickup STRENGTH=0
#exec MESH ORIGIN MESH=BRAssaultGunPickup X=0 Y=0 Z=512
#exec MESHMAP SCALE MESHMAP=BRAssaultGunPickup X=0.00390625 Y=0.00390625 Z=0.00390625
#exec MESH SEQUENCE MESH=BRAssaultGunPickup SEQ=All	STARTFRAME=0	NUMFRAMES=1
#exec MESH SEQUENCE MESH=BRAssaultGunPickup SEQ=Still	STARTFRAME=0	NUMFRAMES=1

#exec MESHMAP SETTEXTURE MESHMAP=BRAssaultGunPickup NUM=0 TEXTURE=BRAssaultGunTex1

#exec obj load file=..\Textures\Area51Textures.utx package=Area51Textures

#exec MESH IMPORT MESH=hellfire ANIVFILE=Models\hellfire_a.3d DATAFILE=Models\hellfire_d.3d X=0 Y=0 Z=0
#exec MESH ORIGIN MESH=hellfire X=0 Y=0 Z=0

#exec MESH SEQUENCE MESH=hellfire SEQ=All STARTFRAME=0 NUMFRAMES=30
//#exec MESH SEQUENCE MESH=hellfire SEQ=??? STARTFRAME=0 NUMFRAMES=30

#exec MESHMAP NEW MESHMAP=hellfire MESH=hellfire
#exec MESHMAP SCALE MESHMAP=hellfire X=1 Y=1 Z=1

defaultproperties
{
}
