//=============================================================================
// WeaponSpiderBot.
//=============================================================================
class eWeaponDrone extends WeaponNPCRanged;

var ElectricityEmitter emitter;
var float zapTimer;
var vector lastHitLocation;
var int shockDamage;

//Poor: Stuff for replication
var bool bClientInit;
var bool bZapping;
var bool bClientStartedZap;
var bool bClientEndedZap;

replication
{
	unreliable if(Role == ROLE_Authority)
		lastHitLocation, bZapping;
}

// force EMP damage
function name WeaponDamageType()
{
	return 'EMP';
}

// intercept the hit and turn on the emitter
function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	Super.ProcessTraceHit(Other, HitLocation, HitNormal, X, Y, Z);

	zapTimer = 0.5;
	bZapping = true;
	if (emitter != None)
	{
		emitter.SetLocation(Owner.Location);
		emitter.SetRotation(Rotator(HitLocation - emitter.Location));
		emitter.TurnOn();
		emitter.proxy.bHidden = true; //Hide the server side beam.
		emitter.SetBase(Owner);
		lastHitLocation = HitLocation;
	}
}

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if(Role == ROLE_Authority)
	{
		if (zapTimer > 0)
		{
			zapTimer -= deltaTime;

			// update the rotation of the emitter
			emitter.SetRotation(Rotator(lastHitLocation - emitter.Location));

			// turn off the electricity after the timer has expired
			if (zapTimer < 0)
			{
				zapTimer = 0;
				bZapping = false;
				emitter.TurnOff();
			}
		}
	}

	if(Role < ROLE_Authority)
	{
		if(!bClientInit)
		{
			if(emitter != None)
			{
				emitter.bFlicker = False;
				emitter.randomAngle = 1024;
				emitter.damageAmount = 0;
				emitter.TurnOff();
				bClientInit = true;
			}
			else
				return;
		}

		if(bZapping)
		{
			if(!bClientStartedZap)
			{
				emitter.TurnOn();
				emitter.SetLocation(Owner.Location);
				emitter.SetRotation(Rotator(lastHitLocation - emitter.Location));
				emitter.SetBase(Owner);
				bClientStartedZap = true;
				bClientEndedZap = false;
			}
			else
				emitter.SetRotation(Rotator(lastHitLocation - emitter.Location));
		}
		else
		{
			if(!bClientEndedZap)
			{
				emitter.TurnOff();
				bClientStartedZap = false;
				bClientEndedZap = true;
			}
		}
	}
}

simulated function Destroyed()
{
	if (emitter != None)
	{
		emitter.Destroy();
		emitter = None;
	}

	Super.Destroyed();
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	zapTimer = 0;
	emitter = Spawn(class'ElectricityEmitter', Self);
	if (emitter != None)
	{
		emitter.bFlicker = False;
		emitter.randomAngle = 1024;
		if(Role == ROLE_Authority)
			emitter.damageAmount = shockDamage;
		else
			emitter.damageAmount = 0; //The client-side emitter shouldn't do any damage.
		emitter.TurnOff();
		emitter.Instigator = Pawn(Owner);
	}
	bClientStartedZap = false;
	bClientEndedZap = false;
}

defaultproperties
{
     shockDamage=15
     ShotTime=1.000000
     HitDamage=25
     maxRange=1280
     AccurateRange=640
     BaseAccuracy=0.000000
     AmmoName=Class'DeusEx.AmmoBattery'
     PickupAmmoCount=200
     bInstantHit=True
     FireSound=Sound'DeusExSounds.Weapons.ProdFire'
}
