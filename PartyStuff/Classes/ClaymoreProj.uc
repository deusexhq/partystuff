//=============================================================================
// TripProj.
//=============================================================================
class ClaymoreProj extends LaserProj;

var float	mpBlastRadius;
var float	mpProxRadius;
var float	mpLAMDamage;
var float	mpFuselength;
var MPLaserEmitter emitter;
var() bool bIsOn;
var bool bConfused;				// used when hit by EMP
var bool bCanFrob;
var float confusionTimer;		// how long until trigger resumes normal operation
var float confusionDuration;	// how long does EMP hit last?
var int HitDamage;
var int HitPoints;
var int minDamageThreshold;
var float TripTimer;
var int charge;

function Timer()
{
	if ((emitter == none))
    {
	    emitter = Spawn(class'MPLaserEmitter');

	    if (emitter != None)
	    {
		   emitter.TurnOn();
		   emitter.bBlueBeam=False;
		   bIsOn = True;
		      bDisabled=False;
		   emitter.SetLocation(Location);
           emitter.SetRotation(Rotation);
	    }
    }
}

function Arm()
{
	bDisabled=False;
   emitter.TurnOn();
   emitter.bBlueBeam=False;
   bIsOn = True;
   emitter.SetLocation(Location);
   emitter.SetRotation(Rotation);
}

simulated function BeginPlay()
{
	local DeusExPlayer aplayer;

	Super(DeusexProjectile).BeginPlay();

	SetCollision(True, True, True);
}

function Tick(float deltaTime)
{
    if ( bIsOn)
    {
      if (emitter != none)
      {
			if ((emitter.HitActor != None) && (!bDisabled))
			{
				if(Pawn(emitter.hitactor) != none)
				{
					Perish();
					Destroy();
				}
			}
      }
    }
}

function Disarm()
{
	emitter.TurnOff();
	bDisabled=True;
	bIsOn = False;
	bCanFrob = True;
	emitter.Destroy();
	emitter = None;
}

// if we are frobbed, turn us off
function Frob(Actor Frobber, Inventory frobWith)
{	
	if(bCanFrob)
	{
		Super.Frob(Frobber, frobWith);
		return;
	}
	Disarm();
}

//This function probably isn't needed.
function Destroyed()
{
	if (emitter != None)
	{
		emitter.Destroy();
		emitter = None;
	}

	Super.Destroyed();
}


//Multiplayer Crap
simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
	{
		blastRadius=mpBlastRadius;
		proxRadius=mpProxRadius;
		Damage=mpLAMDamage;
		fuseLength=mpFuselength;
		bIgnoresNanoDefense=True;
	}
}

function PostBeginPlay()
{
	SetTimer(TripTimer,False);
}

function Trigger( actor Other, pawn EventInstigator )
{
	if(bisOn)
	{
		Disarm();
	}
	else
	{
		SetTimer(1,False);
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

	explosionDamage = 300;
	explosionRadius = 250;

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
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
}

defaultproperties
{
     confusionDuration=10.000000
     TripTimer=1.200000
     fuseLength=0.000000
     proxRadius=0.000000
     blastRadius=256.000000
     spawnWeaponClass=Class'PartyStuff.WeaponClaymore'
     ItemName="Claymore"
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=500.000000
     MomentumTransfer=50000
     ImpactSound=Sound'DeusExSounds.Weapons.LAMExplode'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     LifeSpan=0.000000
     Mesh=LodMesh'DeusExDeco.LaserEmitter'
     CollisionRadius=2.500000
     CollisionHeight=2.500000
     Mass=5.000000
     Buoyancy=2.000000
}
