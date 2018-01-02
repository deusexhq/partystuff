//=============================================================================
// BarrelToxic.
//=============================================================================
class MPParticleProxy extends Actor;

var ParticleGenerator pg;
var() bool bParticlesUnlit;
var() bool bTranslucent;
var() float particleDrawScale;
var() float checkTime;
var() float frequency;
var() float riseRate;
var() float ejectSpeed;
var() float particleLifeSpan;
var() bool bRandomEject;
var() float numPerSpawn;
var() texture particleTexture;
		
function Destroyed()
{
	if (pg != None)
		pg.DelayedDestroy();

	Super.Destroyed();
}

simulated function PostBeginPlay()
{
local ParticleGenerator ToxicDrip;
	Super.PostBeginPlay();

	ToxicDrip = Spawn(class'ParticleGenerator', Self,, Location, rot(16384,0,0));
	if (ToxicDrip != None)
	{
		ToxicDrip.bParticlesUnlit = bParticlesUnlit;
		ToxicDrip.bTranslucent = bTranslucent;
		ToxicDrip.particleDrawScale = particleDrawScale;
		ToxicDrip.checkTime = checkTime;
		ToxicDrip.frequency = frequency;
		ToxicDrip.riseRate = riseRate;
		ToxicDrip.ejectSpeed = ejectSpeed;
		ToxicDrip.particleLifeSpan = particleLifeSpan;
		ToxicDrip.bRandomEject = bRandomEject;
		ToxicDrip.numPerSpawn = numPerSpawn;
		ToxicDrip.particleTexture = particleTexture;
		ToxicDrip.SetBase(Self);
		pg = ToxicDrip;
	}
}

defaultproperties
{
	bParticlesUnlit=True
	bTranslucent=True
	particleDrawScale=0.05
	checkTime=0.25
	frequency=0.8
	riseRate=5.0
	ejectSpeed=10.0
	particleLifeSpan=2.0
	bRandomEject=True
	numPerSpawn=2
	particleTexture=FireTexture'Effects.Smoke.SmokePuff1'
    bHidden=True
}
