//=============================================================================
// Ultima.
//=============================================================================
class Ultima expands DeusExProjectile;

simulated function Tick(float deltaTime)
{
	local SmokeTrail s;

	time += DeltaTime;
	DrawScale = FClamp(2.5*(time+0.5), 1.0, 6.0);
	if ((time > FRand() * 0.02) && (Level.NetMode != NM_DedicatedServer))
	{
		time = 0;

		// spawn some trails
		s = Spawn(class'SmokeTrail',,, Location);
		if (s != None)
		{
			s.DrawScale = FRand() * 0.333;
			s.OrigScale = s.DrawScale;
			s.Texture = Texture'AlarmLightTex2';
			s.Velocity = VRand() * 50;
			s.OrigVel = s.Velocity;
		}
	}
}

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local int i;
	local Rotator rot;
	local SphereEffect sphere;

	// draw a cool light sphere
	sphere = Spawn(class'SphereEffect',,, HitLocation);
	if (sphere != None)
	{
	sphere.RemoteRole = ROLE_None;
	sphere.size = blastradius / 32.0;
	Sphere.MultiSkins[0]=Texture'DeusExDeco.Skins.AlarmLightTex3';
	}
}

simulated function PreBeginPlay()
{
}

defaultproperties
{
     bExplodes=True
     blastRadius=96.000000
     DamageType=Sabot
     ItemName="Blood Sword"
     ItemArticle="the"
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=200.000000
     MomentumTransfer=128
     SpawnSound=Sound'DeusExSounds.UserInterface.DataLinkStart'
     ImpactSound=Sound'DeusExSounds.Weapons.EMPGrenadeExplode'
     ExplosionDecal=Class'DeusEx.BurnMark'
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex2'
     bUnlit=True
     SoundRadius=10
     SoundVolume=255
     SoundPitch=173
}
