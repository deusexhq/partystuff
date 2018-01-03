//=============================================================================
// DarkMaiden.
//=============================================================================
class TrueBobPage extends DXEnemy;

var int DeathTicks;

function PostBeginPlay()
{
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;

    shaketime=1.00;
    shakeRollMagnitude=1024.00;
    shakeVertMagnitude=16.00;
	
	BroadcastMessage("Bob Page has arrived!");
	
	foreach AllActors(class'DeusExPlayer', DXP)
	{
		DXP.PlaySound(Sound'CreditsEnd', SLOT_None,,, 255); //replace with bark from page
		DXP.ShakeView(shakeTime, shakeRollMagnitude, shakeVertMagnitude);
	}
	
	super.PostBeginPlay();
}

function Bool HasTwoHandedWeapon()
{
	return False;
}

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	SpawnCarcass();
	Destroy();
}

function float ShieldDamage(name damageType)
{
	if ( (damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') )
		return 0.0;
        	else if ( (damageType == 'Flamed') || (damageType == 'Poison') || (damageType == 'PoisonEffect') || (damageType == 'Radiation') )
                	return 0.1;
	else if ( (damageType == 'Shocked') || (damageType == 'KnockedOut') || (damageType == 'Fell') )
                	return 0.5;
      	else
		return Super.ShieldDamage(damageType);
}

function Carcass SpawnCarcass()
{
local ExperimentCarcass EC;
	EC = spawn(class'ExperimentCarcass',,,Location,);
	EC.Mesh = Mesh;
	EC.SetRotation(Rotation);
     EC.MultiSkins[0]=Texture'DeusExCharacters.Skins.BobPageTex0';
     EC.MultiSkins[1]=Texture'DeusExCharacters.Skins.BobPageTex2';
     EC.MultiSkins[2]=Texture'DeusExCharacters.Skins.BobPageTex0';
     EC.MultiSkins[3]=Texture'DeusExCharacters.Skins.BobPageTex1';
     EC.MultiSkins[4]=Texture'DeusExCharacters.Skins.BobPageTex1';
     EC.MultiSkins[5]=Texture'DeusExItems.Skins.GrayMaskTex';
     EC.MultiSkins[6]=Texture'DeusExItems.Skins.BlackMaskTex';
     EC.MultiSkins[7]=Texture'DeusExItems.Skins.PinkMaskTex';
	EC.SetTimer(2,True);
	return None;
}

defaultproperties
{
     scoreCredits=700
     BaseAccuracy=-0.250000
     WalkingSpeed=0.280000
     bShowPain=False
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
     SurprisePeriod=0.000000
     InitialAlliances(2)=(AllianceName=Wildcat)
     InitialAlliances(3)=(AllianceName=Agentsmith,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=Carl,AllianceLevel=-1.000000)
     InitialAlliances(6)=(AllianceName=Security,AllianceLevel=-1.000000)
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponPlasmaRifle')
     InitialInventory(1)=(Inventory=Class'DeusEx.WeaponGEPGun')
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=750
     CombatStyle=-0.500000
     NameArticle="true"
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     DrawScale=1.500000
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.BobPageTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.BobPageTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.BobPageTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.BobPageTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.BobPageTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     BindName="TrueBobPage"
     FamiliarName="Augmented Bob Page"
     UnfamiliarName="Augmented Bob Page"
     bVisionImportant=False
}
