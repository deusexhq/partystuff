class LB2 extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;

var float mpDamage;
var float mpBlastRadius;

#exec OBJ LOAD FILE=Effects

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Damage = mpDamage;
	blastRadius = mpBlastRadius;
}

defaultproperties
{
     mpDamage=5.000000
     mpBlastRadius=100.000000
     bExplodes=True
     blastRadius=128.000000
     DamageType=Sabot
     AccurateRange=14400
     maxRange=24000
     bIgnoresNanoDefense=True
     ItemName="Beam Bolt"
     ItemArticle="a"
     speed=1500.000000
     MaxSpeed=1500.000000
     Damage=5.000000
     MomentumTransfer=5000
     ImpactSound=Sound'DeusExSounds.Weapons.PlasmaRifleHit'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Texture=FireTexture'Effects.liquid.Virus_SFX'
     Mesh=LodMesh'DeusExItems.Tracer'
     DrawScale=1.300000
     bUnlit=True
     LightBrightness=200
     LightHue=80
     LightSaturation=128
     LightRadius=3
     bFixedRotationDir=True
}
