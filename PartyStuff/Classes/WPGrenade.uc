class WPGrenade extends GasGrenade;

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ExplosionLight light;
	local ParticleGenerator gen;
   local ExplosionSmall expeffect;

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, HitLocation);
	if (light != None)
   {
      light.RemoteRole = ROLE_None;
		light.size = 12;
   }
	
   expeffect = Spawn(class'ExplosionSmall',,, HitLocation);
   if (expeffect != None)
      expeffect.RemoteRole = ROLE_None;

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
		gen.particleTexture = Texture'Effects.Fire.FireballWhite';
		gen.LifeSpan = 2.0;
	}
}

defaultproperties
{
     DamageType=Flamed
     spawnWeaponClass=Class'WeaponWPGrenade'
     ItemName="WP Grenade"
     ImpactSound=Sound'DeusExSounds.Generic.SmallExplosion2'
}
