// SkullBolt by mouserpg@yahoo.com

class SkullBolt extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;
var float mpDamage;
var float mpBlastRadius;

#exec OBJ LOAD FILE=Effects

simulated function Tick(float deltaTime)
{
	local Rotator rot;

	if (bStuck)
		return;

	Super.Tick(deltaTime);

	if (Level.Netmode != NM_DedicatedServer)
	{
		rot = Rotation;
		rot.Yaw += 16384;
		SetRotation(rot);
	}
}

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal) {
	local ParticleGenerator gen;
	gen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (gen != None) {
      gen.RemoteRole = ROLE_None;
		gen.particleDrawScale = 3.0;
		gen.checkTime = 0.10;
		gen.frequency = 1.0;
		gen.ejectSpeed = 300.0;
		gen.bGravity = True;
		gen.bRandomEject = True;
		gen.particleLifeSpan = 1.0;
		gen.particleTexture = Texture'Effects.Laser.LaserSpot2';
		gen.LifeSpan = 1.3;
	}
}

function PostBeginPlay() {
	Super.PostBeginPlay();
        if ((Level.NetMode == NM_Standalone) || (Level.NetMode == NM_ListenServer))
        SpawnPlasmaEffects();
}
simulated function PreBeginPlay() {
	Super.PreBeginPlay();
	Damage = mpDamage;
	blastRadius = mpBlastRadius;
}
simulated function PostNetBeginPlay() {
   if (Role < ROLE_Authority)
      SpawnPlasmaEffects();
}
simulated function SpawnPlasmaEffects() {
	local Rotator rot;
        rot = Rotation;
	rot.Yaw -= 32768;
        pGen2 = Spawn(class'ParticleGenerator', Self,, Location, rot);
	if (pGen2 != None) {
        pGen2.RemoteRole = ROLE_None;
		pGen2.particleTexture = Texture'Effects.Laser.LaserSpot2';
		pGen2.particleDrawScale = 0.1;
		pGen2.checkTime = 0.04;
		pGen2.riseRate = 0.0;
		pGen2.ejectSpeed = 300.0;
		pGen2.particleLifeSpan = 0.5;
		pGen2.bRandomEject = True;
		pGen2.SetBase(Self);
	}
   
}
simulated function Destroyed() {
	if (pGen1 != None)
	pGen1.DelayedDestroy();
	if (pGen2 != None)
	pGen2.DelayedDestroy();
	Super.Destroyed();
}

defaultproperties
{
     mpDamage=50.000000
     mpBlastRadius=300.000000
     bExplodes=True
     blastRadius=128.000000
     DamageType=exploded
     AccurateRange=24400
     maxRange=24000
     ItemName="Skull Bolt"
     ItemArticle="a"
     speed=1500.000000
     MaxSpeed=1500.000000
     Damage=50.000000
     MomentumTransfer=5000
     ImpactSound=Sound'DeusExSounds.Weapons.PlasmaRifleHit'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Mesh=LodMesh'DeusExDeco.BoneSkull'
     DrawScale=3.000000
     bUnlit=True
     LightBrightness=170
     LightHue=177
     LightSaturation=255
     LightRadius=3
     bFixedRotationDir=True
}
