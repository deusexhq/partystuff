//=============================================================================
// DarkMaiden.
//=============================================================================
class BossCarcass extends CrateUnbreakableMed;

var int DeathTicks;
var ProjectileGenerator attachedGen;

function tick(float v)
{
local deusexplayer dxp;
super.Tick(v);

	Drawscale -= 0.01;
	
	if(Drawscale <= 0.03)
	{
		foreach AllActors(class'DeusExPlayer', DXP)
		{
			PlaySound(Sound'KarkianPainLarge', SLOT_None,,, 255);
		}
		Perish();
		Destroy();
	}
}

function BeginPlay()
{
local ProjectileGenerator PG;

	PG = spawn(class'ProjectileGenerator',,,Location,rot(16384,0,0));
	PG.bRandomEject=True;
	PG.ProjectileClass = class'ExplosionLarge';
	PG.NumPerSpawn = 3;
	PG.CheckTime = 0.5;
	PG.Lifespan=4;
	attachedGen = PG;
}

function Bump(actor Other)
{
//Do nothing.
}

function Timer()
{
local ShockRing s1, s2, s3;
local PRING se;
local int Randy;
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;
    s1 = spawn(class'ShockRing',,,Location,rot(16384,0,0));
	s1.Lifespan = 2.5;
    s2 = spawn(class'ShockRing',,,Location,rot(0,16384,0));
	s2.Lifespan = 2.5;
    s3 = spawn(class'ShockRing',,,Location,rot(0,0,16384));
	S3.Lifespan = 2.5;
	se = spawn(class'PRING',,,Location,rot(16384,0,0));
}

function Perish()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;
	local ProjectileGenerator PG;

	PG = spawn(class'ProjectileGenerator',,,Location,rot(16384,0,0));
	PG.bRandomEject=True;
	PG.ProjectileClass = class'Tracer';
	PG.NumPerSpawn = 5;
	PG.CheckTime = 0.1;
	PG.Lifespan=1;
	explosionDamage = 300;
	explosionRadius = 700;

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

	sphere = Spawn(class'PRING',,, Location);
	if (sphere != None)
		sphere.size += explosionRadius;

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
     ItemName="Dying Experiment"
     bPushable=False
     Physics=PHYS_Rotating
     Texture=FireTexture'Effects.Electricity.Nano_SFX_A'
     Skin=FireTexture'Effects.Electricity.Nano_SFX_A'
     DrawScale=1.500000
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     bCollideActors=False
     bBlockActors=False
     bFixedRotationDir=True
     Mass=500.000000
     RotationRate=(Pitch=11192,Yaw=11192,Roll=11192)
}
