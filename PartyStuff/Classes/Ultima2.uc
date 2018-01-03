//=============================================================================
// SatelliteLaser.
//=============================================================================
class Ultima2 extends DeusExProjectile;


simulated function DrawExplosionEffects(Vector HitLocation, Vector HitNormal)
{
  local Pring pr;
  local ssring sr;
  local explosionlight l;
  local explosionlarge expeffect;
	local int i;
	local Rotator rot;
	local pring sphere;

	// draw a cool light sphere
	sphere = Spawn(class'pring',,, HitLocation);
	if (sphere != None)
	{
	sphere.RemoteRole = ROLE_None;
	sphere.size = blastradius / 32.0;
	Sphere.MultiSkins[0]=Texture'DeusExDeco.Skins.AlarmLightTex3';
	}

l = spawn(class'ExplosionLight',,, HitLocation);
if (l !=None)
{
  l.remoterole = Role_None;
       l.size = 15;
       l.LightHue = 128;
l.LightBrightness = 255;
       l.LightSaturation = 96;
       l.LightEffect = LE_Shell;

}
      }

defaultproperties
{
     bExplodes=True
     blastRadius=700.000000
     DamageType=Sabot
     ItemName="Blood Sword"
     ItemArticle="the"
     speed=3000.000000
     MaxSpeed=3000.000000
     Damage=500.000000
     MomentumTransfer=100000
     ImpactSound=Sound'DeusExSounds.Generic.BioElectricHiss'
     Style=STY_Translucent
     DrawScale=200.000000
     ScaleGlow=10.000000
     Fatness=120
     bUnlit=True
     SoundRadius=255
     SoundVolume=255
     TransientSoundVolume=90.000000
     LightType=LT_SubtlePulse
     LightBrightness=224
     LightHue=51
     LightRadius=255
     Mass=1.000000
}
