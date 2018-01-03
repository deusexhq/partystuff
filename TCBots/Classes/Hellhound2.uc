class Hellhound2 extends Mutt;

var DeusExPlayer myOwner;
var float FlameTime;
var float FlameRand;

function Tick(float deltaSeconds)
{

	Super.Tick(deltaSeconds);

	FlameRand=rand(11);
	FlameTime += deltaSeconds;
	if((AnimSequence=='Attack')||(AnimSequence=='Run')||(AnimSequence=='Roar'))
	{
		if (FlameTime > 0.25)  //spawn once every 1/4 second
		{
			If (FlameRand<8)
			{
				FlameTime = 0;
				Spawn(class'Fireball', Self, , Location + vect(0,0,-2));
			}
			else
			{
				FlameTime=0;
			}
		}
	}
}

function Carcass SpawnCarcass()
{
	if (bStunned)
		return Super.SpawnCarcass();

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

function bool FilterDamageType(Pawn instigatedBy, Vector hitLocation, Vector offset, Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Flamed') || (damageType == 'Burned'))
		return false;
	else
		return Super.FilterDamageType(instigatedBy, hitLocation, offset, damageType);
}

function bool AICanShoot(pawn target, bool bLeadTarget, bool bCheckReadiness, optional float throwAccuracy, optional bool bDiscountMinRange)
{
	return true;
}

defaultproperties
{
     bShowPain=False
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Mutt,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Cat,AllianceLevel=-1.000000)
     InitialInventory(0)=(Inventory=Class'WeaponHellBite')
     Health=600
     AttitudeToPlayer=ATTITUDE_Hate
     Skin=Texture'Hellhound'
     DrawScale=2.000000
     CollisionRadius=55.000000
     CollisionHeight=51.000000
     BindName="Hellhound"
     FamiliarName="Hellhound"
     UnfamiliarName="Hellhound"
}
