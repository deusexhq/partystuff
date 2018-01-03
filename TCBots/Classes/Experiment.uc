//=============================================================================
// DarkMaiden.
//=============================================================================
class Experiment extends DXEnemy;

var int DeathTicks;

function PostBeginPlay()
{
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;
local int MeshRand, HealthRand;
	
	HealthRand = Rand(800);
	MeshRand = Rand(3);
	
	 HealthHead += HealthRand;
     HealthTorso += HealthRand;
     HealthLegLeft += HealthRand;
     HealthLegRight += HealthRand;
     HealthArmLeft += HealthRand;
     HealthArmRight += HealthRand;
	 scoreCredits += HealthRand;
	 Health += HealthRand;
	 
	//branch for GM_Trench
	if(MeshRand <= 1)
	{
		bIsFemale=False;
		Mesh=LodMesh'DeusExCharacters.GM_Trench';
	}
	//branch for GFM_Trench
	if(MeshRand == 2)
	{
		bIsFemale=True;
		Mesh=LodMesh'DeusExCharacters.GFM_Trench';
	}	
	//branch for GFM_TShirtPants
	if(MeshRand == 3)
	{
		bIsFemale=True;
		Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants';
	}	

    shaketime=1.00;
    shakeRollMagnitude=1024.00;
    shakeVertMagnitude=16.00;
	
	BroadcastMessage("The Experiment has awoken!");
	
	foreach AllActors(class'DeusExPlayer', DXP)
	{
		DXP.PlaySound(Sound'KarkianPainLarge', SLOT_None,,, 255);
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
     InitialInventory(2)=(Inventory=Class'WeaponNanoSword')
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=750
     CombatStyle=-0.500000
     NameArticle=" The "
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     DrawScale=1.500000
     MultiSkins(0)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(1)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(2)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(3)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(4)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(5)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(6)=FireTexture'Effects.Electricity.Nano_SFX_A'
     MultiSkins(7)=FireTexture'Effects.Electricity.Nano_SFX_A'
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     BindName="Experiment"
     FamiliarName="Experiment"
     UnfamiliarName="Experiment"
     bVisionImportant=False
}
