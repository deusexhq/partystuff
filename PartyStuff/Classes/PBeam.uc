//=============================================================================
// PressureBeam.
//=============================================================================
class PBeam extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;

var float mpDamage;
var float mpBlastRadius;

#exec OBJ LOAD FILE=Effects

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ParticleGenerator gen;

	// create a particle generator shooting out plasma spheres
	gen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (gen != None)
	{
      gen.RemoteRole = ROLE_None;
		gen.particleDrawScale = 2.3;
		gen.checkTime = 0.10;
		gen.frequency = 3.0;
		gen.ejectSpeed = 400.0;
		gen.bGravity = True;
		gen.bRandomEject = True;
		gen.particleLifeSpan = 6.75;
		gen.particleTexture = Texture'Effects.Fire.Proj_PRifle';
		gen.LifeSpan = 1.3;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

   if ((Level.NetMode == NM_Standalone) || (Level.NetMode == NM_ListenServer))
      SpawnPlasmaEffects();
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Damage = mpDamage;
	blastRadius = mpBlastRadius;
}

simulated function PostNetBeginPlay()
{
   if (Role < ROLE_Authority)
      SpawnPlasmaEffects();
}

// DEUS_EX AMSD Should not be called as server propagating to clients.
simulated function SpawnPlasmaEffects()
{
	local Rotator rot;
   rot = Rotation;
	rot.Yaw -= 32768;

   pGen2 = Spawn(class'ParticleGenerator', Self,, Location, rot);
	if (pGen2 != None)
	{
      pGen2.RemoteRole = ROLE_None;
		pGen2.particleTexture = Texture'Effects.Fire.Proj_PRifle';
		pGen2.particleDrawScale = 0.3;
		pGen2.checkTime = 0.04;
		pGen2.riseRate = 0.0;
		pGen2.ejectSpeed = 100.0;
		pGen2.particleLifeSpan = 6.5;
		pGen2.bRandomEject = True;
		pGen2.SetBase(Self);
	}

}

simulated function Destroyed()
{
	if (pGen1 != None)
		pGen1.DelayedDestroy();
	if (pGen2 != None)
		pGen2.DelayedDestroy();

	Super.Destroyed();
}

defaultproperties
{
     mpDamage=25.000000
     mpBlastRadius=700.000000
     bExplodes=True
     bBlood=True
     bDebris=True
     blastRadius=128.000000
     DamageType=Electrified
     AccurateRange=14400
     maxRange=54000
     bIgnoresNanoDefense=True
     ItemName="Pressure Beam"
     ItemArticle="a"
     speed=1500.000000
     MaxSpeed=1500.000000
     Damage=40.000000
     MomentumTransfer=9000
     ImpactSound=Sound'DeusExSounds.Weapons.PlasmaRifleHit'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Skin=FireTexture'Effects.Fire.flmethrwr_flme'
     Mesh=LodMesh'DeusExItems.PlasmaBolt'
     DrawScale=5.000000
     bUnlit=True
     LightBrightness=200
     LightHue=80
     LightSaturation=128
     LightRadius=3
     bFixedRotationDir=True
}
