//=============================================================================
// DarkMaiden.
//=============================================================================
class ExperimentCarcass extends CrateUnbreakableMed;

var int DeathTicks;
var bool bRaising;
var ProjectileGenerator attachedGen;

function BeginPlay()
{
local ProjectileGenerator PG;

	PG = spawn(class'ProjectileGenerator',,,Location,rot(16384,0,0));
	PG.bRandomEject=True;
	PG.ProjectileClass = class'PlasmaBoltEx';
	PG.NumPerSpawn = 5;
	PG.CheckTime = 1;
	PG.Lifespan=10;
	attachedGen = PG;
}

function Bump(actor Other)
{
//Do nothing.
}

function Tick(float Deltatime)
{
	local vector newLocation;
	newLocation=attachedGen.Location;	
	newLocation.Z+=(15*deltaTime);
	attachedGen.SetLocation(newLocation);

	newLocation=self.Location; 
	newLocation.Z+=(15*deltaTime);
	SetLocation(newLocation);
}

function Timer()
{
local ShockRing s1, s2, s3;
local SphereEffect se;
local int Randy;
local DeusExPlayer DXP;
local float shakeTime;
local float shakeRollMagnitude;
local float shakeVertMagnitude;
	PlaySound(Sound'DeusExSounds.Animal.KarkianPainSmall', SLOT_None,,,, 30);
    s1 = spawn(class'ShockRing',,,Location,rot(16384,0,0));
	s1.Lifespan = 2.5;
    s2 = spawn(class'ShockRing',,,Location,rot(0,16384,0));
	s2.Lifespan = 2.5;
    s3 = spawn(class'ShockRing',,,Location,rot(0,0,16384));
	S3.Lifespan = 2.5;
	se = spawn(class'SphereEffect',,,Location,rot(16384,0,0));
	se.Skin=FireTexture'Effects.Electricity.Virus_SFX';
	se.Texture=FireTexture'Effects.Electricity.Virus_SFX';
	se.Lifespan = 2.5;
	DeathTicks++;
	
	if(DeathTicks==8)
	{
		foreach AllActors(class'DeusExPlayer', DXP)
		{
			PlaySound(Sound'KarkianPainLarge', SLOT_None,,, 255);
			DXP.ShakeView(shakeTime, shakeRollMagnitude, shakeVertMagnitude);
		}
		Perish();
		Destroy();
	}
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
     ItemName="Dying Experiment"
     bPushable=False
     Texture=FireTexture'Effects.Electricity.Nano_SFX_A'
     Skin=FireTexture'Effects.Electricity.Nano_SFX_A'
     DrawScale=1.500000
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     bCollideActors=False
     bBlockActors=False
}
