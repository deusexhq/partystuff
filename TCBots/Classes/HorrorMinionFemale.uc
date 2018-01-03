//=============================================================================
// DarkMaiden.
//=============================================================================
class HorrorMinionfemale extends DXEnemy;

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
	Super.Tick(deltaTime);
}

function PostBeginPlay()
{
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;
local int MeshRand, HealthRand;
	
	HealthRand = Rand(110);
	
	 HealthHead += HealthRand;
     HealthTorso += HealthRand;
     HealthLegLeft += HealthRand;
     HealthLegRight += HealthRand;
     HealthArmLeft += HealthRand;
     HealthArmRight += HealthRand;
	 scoreCredits += HealthRand;
	 Health += HealthRand;
	
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
	Explode();

	return None;
}

function Explode()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 200;
	explosionRadius = 200;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'femaleWaterDeath', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionLarge',,, Location + 2*VRand()*CollisionRadius);

	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;
		sphere.Skin=FireTexture'Effects.Electricity.Virus_SFX';
		sphere.Texture=FireTexture'Effects.Electricity.Virus_SFX';

	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.3)
			spawn(class'FleshFragment',,,Location);
		else
			spawn(class'FleshFragment',,,Location);
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
	Destroy();
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
     InitialInventory(1)=(Inventory=Class'WeaponNanoSword')
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
     Mesh=LodMesh'DeusExCharacters.GFM_Dress'
     MultiSkins(0)=Texture'DeusExItems.Skins.FleshFragmentTex1'
     MultiSkins(1)=Texture'DeusExItems.Skins.FleshFragmentTex1'
     MultiSkins(2)=Texture'DeusExItems.Skins.FleshFragmentTex1'
     MultiSkins(3)=Texture'DeusExItems.Skins.FleshFragmentTex1'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExDeco.Skins.BoneSkullTex1'
     MultiSkins(7)=Texture'DeusExDeco.Skins.BoneSkullTex1'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="HorrorFemale"
     FamiliarName="Horror"
     UnfamiliarName="Horror"
     bVisionImportant=False
}
