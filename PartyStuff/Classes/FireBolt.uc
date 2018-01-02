//=============================================================================
// FireBolt.
//=============================================================================
class FireBolt extends Rocket;

#exec OBJ LOAD FILE=Effects

var() float shakeTime;
var() float shakeRollMagnitude;
var() float shakeVertMagnitude;

var SizableEffectSpawner efs;

simulated function SpawnRocketEffects()
{
	efs = Spawn(class'SizableEffectSpawner',,,Location);
	if (efs != None)
	{
		efs.SetBase(Self);
		efs.RemoteRole = ROLE_None;
		efs.EffectClass=class'MagicRing';
		efs.EffectSkin = Texture'DeusExDeco.Skins.AlarmLightTex8';
		efs.SizeofEffect = 3;
		efs.Interval = 0.01;
		efs.EffectLSpan = 1.0;
   	}
}

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ExplosionLight light;
	local ParticleGenerator gen;
   	local ExplosionSmall expeffect;

	//destroy the other effect
	efs.Destroy();
	
	// draw a pretty explosion
	/*light = Spawn(class'ExplosionLight',,, HitLocation);
	if (light != None)
   	{
      		light.RemoteRole = ROLE_None;
		light.size = 12;
	}*/
	
   	/*expeffect = Spawn(class'ExplosionSmall',,, HitLocation);
	if (expeffect != None)
      		expeffect.RemoteRole = ROLE_None;*/

	// create a particle generator shooting out white-hot fireballs
	gen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (gen != None)
	{
      		gen.RemoteRole = ROLE_None;
		gen.particleDrawScale = 1.0;
		gen.checkTime = 0.05;
		gen.frequency = 1.0;
		gen.ejectSpeed = 200.0;
		gen.bGravity = True;
		gen.bRandomEject = True;
		gen.particleTexture = FireTexture'Effects.Fire.flame_b';
		gen.LifeSpan = 2.0;
	}
}

function ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);

	// If the dart enters water, extingish it
	if (NewZone.bWaterZone)
	{
		//destroy the other effect
		efs.Destroy();
		
		Destroy();
	}
}

defaultproperties
{
     bBlood=False
     bDebris=False
     blastRadius=512.000000
     DamageType=Flamed
     ItemName="Fire Bolt"
     Damage=50.000000
     SpawnSound=None
     ImpactSound=Sound'DeusExSounds.Weapons.FlamethrowerFire'
     Mesh=None
     DrawScale=1.000000
     AmbientSound=None
}
