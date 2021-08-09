//=============================================================================
// TripProj.
//=============================================================================
class TripProjEMP extends LaserProj;

var float	mpBlastRadius;
var float	mpProxRadius;
var float	mpLAMDamage;
var float	mpFuselength;
var mpLaserEmitter emitter;
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

function Arm()
{
   emitter.TurnOn();
   emitter.bBlueBeam=False;
   bIsOn = True;
   emitter.SetLocation(Location);
   emitter.SetRotation(Rotation);
      bDisabled=False;
}

function Tick(float deltaTime)
{
local ScriptedPawn P;
local DeusExPlayer Player;

    if ( bIsOn)
    {
      if (emitter != none)
      {
		if ((emitter.HitActor != None) && (!bDisabled))
		{
			if(Pawn(emitter.hitactor) != none)
			{
				Pawn(emitter.hitactor).TakeDamage(20,DeusExPlayer(Owner),emitter.hitactor.location,vect(0,0,0),'EMP');
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
	Emitter.Destroy();
	emitter = none;
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

simulated function BeginPlay()
{
	local DeusExPlayer aplayer;

	Super(DeusexProjectile).BeginPlay();

	SetCollision(True, True, True);
}

function PostBeginPlay()
{
	SetTimer(TripTimer,False);
}

defaultproperties
{
     confusionDuration=10.000000
     TripTimer=3.000000
     fuseLength=0.000000
     proxRadius=0.000000
     blastRadius=256.000000
     spawnWeaponClass=Class'PartyStuff.WeaponTripBombEMP'
     ItemName="Laser EMP"
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
