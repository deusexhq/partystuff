//=============================================================================
// PlasmaBolt.
//=============================================================================
class PSFireworkRocket extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;

var float mpDamage;
var float mpBlastRadius;

#exec OBJ LOAD FILE=Effects

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ParticleGenerator gen;
local pring sphere;
local ProjectileGenerator Projy;
	
	projy = Spawn(class'ProjectileGenerator',,,HitLocation);
	projy.Lifespan=5;
	projy.EjectSpeed=250;
	projy.Checktime=0.01;
	projy.bRandomEject = True;
	projy.ProjectileClass=class'PSFireworkfx';
	projy.NumPerSpawn=3;
	// create a particle generator shooting out plasma spheres
	gen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (gen != None)
	{
      //gen.RemoteRole = ROLE_None;
		gen.particleDrawScale = 1.0;
		gen.checkTime = 0.10;
		gen.frequency = 1.0;
		gen.ejectSpeed = 200.0;
		gen.bGravity = True;
		gen.bRandomEject = True;
		gen.particleLifeSpan = 0.75;
		gen.particleTexture = Texture'sparkfx1';
		gen.LifeSpan = 1.3;
	}
	sphere = Spawn(class'pring',,, HitLocation);
	if (sphere != None)
	{
	sphere.size = blastradius / 32;
	Sphere.MultiSkins[0]=Texture'radattack';
	}
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Damage = mpDamage;
	blastRadius = mpBlastRadius;
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
     mpBlastRadius=300.000000
     bExplodes=True
     blastRadius=128.000000
     DamageType=Burned
     AccurateRange=14400
     maxRange=24000
     bIgnoresNanoDefense=True
     ItemName="Firework"
     ItemArticle="a"
     speed=1000.000000
     MaxSpeed=1100.000000
     MomentumTransfer=3000
     ImpactSound=Sound'DeusExSounds.Generic.MediumExplosion1'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Style=STY_Modulated
     Skin=FireTexture'Effects.Fire.flmethrwr_fire'
     Mesh=LodMesh'DeusExItems.PlasmaBolt'
     DrawScale=2.000000
     Fatness=88
     bUnlit=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=200
     LightHue=1
     LightSaturation=128
     LightRadius=3
     bFixedRotationDir=True
}
