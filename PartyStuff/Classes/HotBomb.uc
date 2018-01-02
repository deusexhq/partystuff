class HotBomb extends CrateExplosiveSmall;
//NEW MESH by Vodun Loas
#exec obj load FILE=Ambient
#exec obj load FILE=Area51Textures
var bool bArmed;
var() int AffectRadius;
var int Randy, curCount, minCount, maxCount;

function BeepLocal(string Str)
{
local DeusExPlayer P;

	foreach RadiusActors(class'DeusExPlayer', P, AffectRadius)
	{
			P.ClientMessage(str,'TeamSay');
	}
}

function PostBeginPlay()
{
	BeepLocal("|Cfff005Hot BOMB in play!! Pick up to activate");
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer Player;
	
	if(!bArmed)
	{
		Randy = randrange(minCount,maxCount);
		SetTimer(float(Randy),False);
		bArmed = True;
		bPushable = True;
		BeepLocal("|Cfff005Timer started!");
				 LightBrightness=255;
     Lighttype=LT_Steady;
     LightRadius=15;
     Ambientglow=255;
     LightSaturation=0;
		ambientSound = sound'ambient.lamambient';
		super.Frob(Frobber, frobWith);	
	}
	else
	{
		super.Frob(Frobber, frobWith);	
	}
}

function Trigger( actor Other, pawn EventInstigator )
{
	if(!bArmed)
	{
		Randy = randrange(minCount,maxCount);
		SetTimer(float(Randy),False);
		bArmed = True;
		bPushable = True;
		ambientSound = sound'ambient.lamambient';
		 LightBrightness=255;
     Lighttype=LT_Steady;
     LightRadius=15;
     Ambientglow=255;
     LightSaturation=0;
		BeepLocal("|Cfff005Timer started!");		
	}
}

function Timer()
{
	BeepLocal("|Cfff005HOT BOMB HAS BLOWN.");
	ExplodeTime();
}

function ExplodeTime()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 300;
	explosionRadius = 150;

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

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
	Destroy();
}


function Bump(actor Other)
{
}

defaultproperties
{
  Mesh=Mesh'hellfire'
    CollisionRadius=14.00000
  CollisionHeight=34.00000
    MultiSkins(0)=Texture'Area51Textures.Metal.pa_nukewste_a'
  MultiSkins(1)=Texture'Area51Textures.Metal.area51shere_a'
  MultiSkins(2)=Texture'Area51Textures.Metal.A51_Wall_11'
     AffectRadius=700
     minCount=5
     MaxCount=20
     bInvincible=True
     ItemName="Hot BOMB"
     bPushable=False
}
