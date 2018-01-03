//=============================================================================
// DarkMaiden.
//=============================================================================
class Horror extends DXEnemy;

var int DeathTicks;
var float time;
var float damageRadius;
var float damageInterval;
var float damageAmount;
var float damageTime;

function Tick(float deltaTime)
{
	local DeusExPlayer player;

	damageTime += deltaTime;
	time += deltaTime;

	// check for random noises
	if (time > 1.0)
	{
		time = 0;
		if (FRand() < 0.1)
			PlaySound(sound'GrayFlee', SLOT_None,,, 128);
	}
	if (damageTime >= damageInterval)
	{
		damageTime = 0;
		foreach VisibleActors(class'DeusExPlayer', player, damageRadius)
			if (player != None)
				player.DrugEffectTimer+=5;
	}

	Super.Tick(deltaTime);
}

function PostBeginPlay()
{
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;
local int MeshRand, HealthRand;
	
	HealthRand = Rand(800);
	
	 HealthHead += HealthRand;
     HealthTorso += HealthRand;
     HealthLegLeft += HealthRand;
     HealthLegRight += HealthRand;
     HealthArmLeft += HealthRand;
     HealthArmRight += HealthRand;
	 scoreCredits += HealthRand;
	 Health += HealthRand;
	 
    shaketime=1.00;
    shakeRollMagnitude=1024.00;
    shakeVertMagnitude=16.00;
	
	BroadcastMessage("The Horror has awoken!");
	
	foreach AllActors(class'DeusExPlayer', DXP)
	{
		DXP.PlaySound(Sound'GrayFlee', SLOT_None,,, 255);
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
		EC.Multiskins[0] = Multiskins[0];
	EC.Multiskins[1] = Multiskins[1];
	EC.Multiskins[2] = Multiskins[2];
	EC.Multiskins[3] = Multiskins[3];
	EC.Multiskins[4] = Multiskins[4];
	EC.Multiskins[5] = Multiskins[5];
	EC.Multiskins[6] = Multiskins[6];
	EC.Multiskins[7] = Multiskins[7];
	EC.SetRotation(Rotation);
	EC.SetTimer(2,True);
	return None;
}

defaultproperties
{
	     DamageRadius=256.000000
     damageInterval=1.000000
     DamageAmount=10.000000
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
     InitialInventory(0)=(Inventory=Class'WeaponBioRifleX')
     InitialInventory(1)=(Inventory=Class'WeaponNanosword')
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=750
     CombatStyle=-0.500000
     NameArticle=""
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     DrawScale=1.500000
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExDeco.Skins.BoneSkullTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.GordonQuickTex2'
     MultiSkins(2)=Texture'DeusExItems.Skins.FleshFragmentTex1'
     MultiSkins(3)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.FleshFragmentTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.GordonQuickTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     BindName="Horror"
     FamiliarName="Horror"
     UnfamiliarName="Horror"
     bVisionImportant=False
}
