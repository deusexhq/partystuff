class RocketDrone extends DeusExProjectile;

var float time;
var float dist;
var Rotator dir;
var vector TargetLocation;
var rotator TargetDir;
var rotator RandomAdd;
var rotator HeightAdjAdd;
var rotator Rand;
var() float proxRadius; 
var() bool bfalloff; 
var() float certainity;
var float certainity2;
var() float drunkness; 
var() float sharpness; 
var() float heightAdj; 
var() float tickTime; 
var() float minMass; 
var rotator RotationOld;
var Pawn P;
var Pawn Itarget; 
var pawn Ignorer;

function PostBeginPlay()
{
	TargetLocation = Location; 
	bRotateToDesired = True;
	DesiredRotation = Rotation;
}

simulated function Tick(float deltaTime)
{
	if (time >= tickTime)
	{
		time = 0;
		if ((dist > proxRadius) || (Itarget == None)) //then try find a new target
		{
			Itarget = None;
			foreach RadiusActors(class'Pawn', P, proxRadius)
			{
				if ((P != None) && (P.Mass >=40) && (P != Ignorer))
				{
					if (P != Owner)
						Itarget = P;
				}
			}
		}
		else
			Itarget = None;
		DoGuidance();
	}
	else
		time += deltaTime;
}

function DoGuidance()
{
	if (Itarget != None)
	{
		TargetLocation = Itarget.Location;
		dist = Vsize(TargetLocation - Location);
		if ((bfalloff) && (proxRadius != 0))
			certainity2 = ((proxRadius-dist) * certainity ) / proxRadius;
		else
			certainity2 = certainity;
	}
	else
		certainity2 = 0;
	Rand = Rotator(Vrand());
	TargetDir = Rotator(TargetLocation - Location);
	RandomAdd = (TargetDir-Rotation)*certainity2+Rand*(1-certainity2)*drunkness;
	HeightAdjAdd = Rotation*heightAdj + RandomAdd * sharpness * (1-heightAdj);
	RotationOld = Rotation; 
	DesiredRotation = RotationOld + RandomAdd*sharpness;

	velocity = Vector(Rotation) * Speed;
}


defaultproperties
{
    proxRadius=800.00
    certainity=1.00
    drunkness=0.10
    sharpness=1.00
    tickTime=0.10
    minMass=40.00
    bExplodes=True
    bBlood=True
    bDebris=True
    blastRadius=64.00
    DamageType=exploded
    AccurateRange=14400
    maxRange=24000
    ItemName="Drone Rocket"
    ItemArticle="a"
    speed=700.00
    MaxSpeed=1500.00
    Damage=50.00
    MomentumTransfer=10000
    SpawnSound=Sound'DeusExSounds.Weapons.GEPGunFire'
    ImpactSound=Sound'DeusExSounds.Generic.SmallExplosion1'
    Mesh=LodMesh'DeusExItems.Rocket'
    DrawScale=0.10
    SoundRadius=16
    SoundVolume=196
    AmbientSound=Sound'DeusExSounds.Special.RocketLoop'
    RotationRate=(Pitch=99999,Yaw=65536,Roll=0),
}
