//=============================================================================
// DarkMaiden.
//=============================================================================
class LivingMannequinMale extends DXEnemy;

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	SpawnCarcass();
	Destroy();
}

function Bool HasTwoHandedWeapon()
{
	return False;
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
local Mannequin EC;
	EC = spawn(class'Mannequin',,,Location,);
	EC.Mesh = Mesh;
	 EC.MultiSkins[0]=MultiSkins[0];
     EC.MultiSkins[1]=MultiSkins[1];
     EC.MultiSkins[2]=MultiSkins[2];
     EC.MultiSkins[3]=MultiSkins[3];
     EC.MultiSkins[4]=MultiSkins[4];
     EC.MultiSkins[5]=MultiSkins[5];
     EC.MultiSkins[6]=MultiSkins[6];
     EC.MultiSkins[7]=MultiSkins[7];
	EC.SetRotation(Rotation);
	EC.bInvincible=False;
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

	explosionDamage = 100;
	explosionRadius = 256;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

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

	// spawn a mark
	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Location);
		else
			spawn(class'FleshFragment',,,Location);
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
}


function Gasp()
{
}

function PlayDyingSound()
{
}

function PlayIdleSound()
{
}

function PlayScanningSound()
{
}

function PlayPreAttackSearchingSound()
{
}

function PlayPreAttackSightingSound()
{
}

function PlayPostAttackSearchingSound()
{
}

function PlayTargetAcquiredSound()
{
}

function PlayTargetLostSound()
{
}

function PlaySearchGiveUpSound()
{
}

function PlayNewTargetSound()
{
	// someday...
}

function PlayGoingForAlarmSound()
{
}

function PlayOutOfAmmoSound()
{
}

function PlayCriticalDamageSound()
{
}

function PlayAreaSecureSound()
{
}

function PlayFutzSound()
{
}

function PlayOnFireSound()
{
}

function PlayTearGasSound()
{
}

function PlayCarcassSound()
{
}

function PlaySurpriseSound()
{
}

function PlayAllianceHostileSound()
{
}

function PlayAllianceFriendlySound()
{
}

function PlayTakeHitSound(int Damage, name damageType, int Mult)
{
	local Sound hitSound;
	local float volume;

	if (Level.TimeSeconds - LastPainSound < 0.25)
		return;
	if (Damage <= 0)
		return;

	LastPainSound = Level.TimeSeconds;

	if (Damage <= 30)
		hitSound = HitSound1;
	else
		hitSound = HitSound2;
	volume = FMax(Mult*TransientSoundVolume, Mult*2.0);

	SetDistressTimer();
	PlaySound(hitSound, SLOT_Pain, volume,,, RandomPitch());
	if ((hitSound != None) && bEmitDistress)
		AISendEvent('Distress', EAITYPE_Audio, volume);
}

defaultproperties
{
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
     InitialAlliances(6)=(AllianceName=Security,AllianceLevel=-1.000000)
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'WeaponCrowbar')
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=750
     CombatStyle=-0.500000
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(1)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionHeight=47.299999
     BindName="Mannequin"
     FamiliarName="Living Mannequin"
     UnfamiliarName="Living Mannequin"
     bVisionImportant=False
}
