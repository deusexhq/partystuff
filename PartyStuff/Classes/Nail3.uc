//=============================================================================
// Nail.  
//=============================================================================
class Nail3 extends DeusExProjectile;

var float mpDamage;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
		Damage = mpDamage;
}

function BeginPlay()
{
	spawn(class'SmokeTrail',,, Location);
}

defaultproperties
{
     mpDamage=30.000000
     bBlood=True
     bStickToWall=True
     DamageType=exploded
     bIgnoresNanoDefense=True
     ItemName="Nail Gun"
     ItemArticle="a"
     speed=5000.000000
     MaxSpeed=7000.000000
     Damage=15.000000
     MomentumTransfer=10000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Texture=Texture'PGAssets.Skins.NailTex3'
     Skin=Texture'PGAssets.Skins.NailTex3'
     Mesh=LodMesh'DeusExItems.Dart'
     DrawScale=2.000000
     CollisionRadius=3.000000
     CollisionHeight=0.500000
}
