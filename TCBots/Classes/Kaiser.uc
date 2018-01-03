//=============================================================================
// DarkMaiden.
//=============================================================================
class Kaiser extends DXEnemy;

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
	
	BroadcastMessage("Kaiser has appeared!");
	
	foreach AllActors(class'DeusExPlayer', DXP)
	{
		DXP.PlaySound(Sound'DeusExSounds.Player.MaleLaugh', SLOT_None,,, 255);
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
AllyClass=class'Seventeen'
AllianceGroup="Admins"
	tScanning=""
	tTargetAcquired="Time to die."
	tTargetLost="You'll be back."
	tCriticalDamage="You'll regret that.."
	tAreaSecure="*sighs*"
	tBossArmourDown="I paid good money for that armour!"
	tBossArmourBack=""
	tMedkitUsed=""
	tCallingBackup=""
	bBossArmour=True
	BossArmour=800
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
     InitialAlliances(3)=(AllianceName=Agentsmith,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=Carl,AllianceLevel=-1.000000)
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponRifle')
     InitialInventory(1)=(Inventory=Class'WeaponAssaultgun')
     InitialInventory(2)=(Inventory=Class'WeaponNanoSword')
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=1900
     CombatStyle=-0.500000
     HealthHead=1900
     HealthTorso=1900
     HealthLegLeft=1900
     HealthLegRight=1900
     HealthArmLeft=1900
     HealthArmRight=1900
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     DrawScale=1.500000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex4'
     MultiSkins(1)=Texture'KaiAlt2Tex3'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.Male4Tex2'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaxChenTex1'
     MultiSkins(5)=Texture'KaiAlt2Tex3'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     BindName="Kaiser"
     FamiliarName="Kaiser"
     UnfamiliarName="Kaiser"
     bVisionImportant=False
}
