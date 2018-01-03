//=============================================================================
// DarkMaiden.
//=============================================================================
class Wildcat extends DXHumanMilitary;

function MakeSmoke()
{
local ProjectileGenerator PG;

	PG = spawn(class'ProjectileGenerator',,,Location,rot(16384,0,0));
	PG.bRandomEject=True;
	PG.ProjectileClass = class'SmokeCloud';
	PG.ProjectileLifespan = 2;
	PG.NumPerSpawn = 5;
	PG.CheckTime = 1;
	PG.Lifespan=10;
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
	bBlockActors=False;
	MakeSmoke();
	spawn(class'Hellkitty',,,Location,Rotation);
	Destroy();
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

defaultproperties
{
     BaseAccuracy=-0.250000
     WalkingSpeed=0.280000
     bShowPain=False
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
     SurprisePeriod=0.000000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponStealthPistol')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo10mm',Count=36)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponMiniCrossbow')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoDartPoison',Count=12)
     InitialInventory(4)=(Inventory=Class'DeusEx.WeaponNanoSword')
     BurnPeriod=0.000000
     bIsFemale=True
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
     Mesh=LodMesh'DeusExCharacters.GFM_Dress'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Hooker2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex3'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex2'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.Hooker2Tex0'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.Hooker2Tex0'
     CollisionHeight=47.299999
     BindName="Wildcat"
     FamiliarName="Wildcat"
     UnfamiliarName="Wildcat"
     bVisionImportant=False
}
