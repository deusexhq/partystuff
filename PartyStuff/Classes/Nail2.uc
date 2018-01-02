//=============================================================================
// Nail.  
//=============================================================================
class Nail2 extends DeusExProjectile;

var float mpDamage;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
		Damage = mpDamage;
}

defaultproperties
{
     mpDamage=3.000000
     bBlood=True
     bStickToWall=True
     DamageType=shot
     bIgnoresNanoDefense=True
     ItemName="Nail Gun"
     ItemArticle="a"
     speed=5000.000000
     MaxSpeed=7000.000000
     Damage=4.000000
     MomentumTransfer=10000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Texture=Texture'NailTex4'
     Skin=Texture'NailTex4'
     Mesh=LodMesh'DeusExItems.Dart'
     CollisionRadius=3.000000
     CollisionHeight=0.500000
}
