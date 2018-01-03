//=============================================================================
// DarkMaiden.
//=============================================================================
class Carlos extends DXEnemy;

var int DeathTicks;

function PostBeginPlay()
{
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;
local int MeshRand, HealthRand;

    shaketime=1.00;
    shakeRollMagnitude=1024.00;
    shakeVertMagnitude=16.00;
	
	BroadcastMessage("Carlos has appeared!");
	
	foreach AllActors(class'DeusExPlayer', DXP)
	{
		DXP.PlaySound(Sound'DeusExSounds.UserInterface.Menu_SpeechTest', SLOT_None,,, 255);
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
local BossCarcass EC;
	EC = spawn(class'BossCarcass',,,Location,);
	EC.Mesh = Mesh;
	EC.SetRotation(Rotation);
	 EC.MultiSkins[0]=MultiSkins[0];
     EC.MultiSkins[1]=MultiSkins[1];
     EC.MultiSkins[2]=MultiSkins[2];
     EC.MultiSkins[3]=MultiSkins[3];
     EC.MultiSkins[4]=MultiSkins[4];
     EC.MultiSkins[5]=MultiSkins[5];
     EC.MultiSkins[6]=MultiSkins[6];
     EC.MultiSkins[7]=MultiSkins[7];
	EC.SetTimer(0.6,True);
	return None;
}

defaultproperties
{
AllyClass=class'Haddaway'
AllianceGroup="Admins"
	tScanning="My wood senses are tingling."
	tTargetAcquired="You = found."
	tTargetLost="Ffs, where are you hiding."
	tCriticalDamage="You broke my chopstick."
	tAreaSecure="*whistles*"
	tBossArmourDown="Nooooooooo!"
	tBossArmourBack="Wood Armour is ready to rock."
	tMedkitUsed="My medkit is augmented."
	tCallingBackup="Chop chop!"
	bBossArmour=True
	BossArmour=300
	Medkits=2
     scoreCredits=1000
     BaseAccuracy=-0.250000
     WalkingSpeed=0.280000
     bShowPain=False
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
     SurprisePeriod=0.000000
     InitialAlliances(2)=(AllianceName=DarkoE,AllianceLevel=-1.000000)
     InitialAlliances(3)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Carl,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=PartyPolice,AllianceLevel=-1.000000)
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.WeaponRifle')
     InitialInventory(2)=(Inventory=Class'WeaponNanoSword')
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=1750
     CombatStyle=-0.500000
     HealthHead=1750
     HealthTorso=1750
     HealthLegLeft=1750
     HealthLegRight=1750
     HealthArmLeft=1750
     HealthArmRight=1750
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     DrawScale=1.500000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Male1Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.GordonQuickTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JaimeReyesTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.GordonQuickTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     BindName="Carlos"
     FamiliarName="Carlos"
     UnfamiliarName="Carlos"
     bVisionImportant=False
}
