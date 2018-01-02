//=============================================================================
// Shuriken.
//=============================================================================
class MomsKnife extends DeusExProjectile;

var float	mpDamage;
var int		mpAccurateRange;
var int		mpMaxRange;

// set it's rotation correctly
simulated function Tick(float deltaTime)
{
	local Rotator rot;

	if (bStuck)
		return;

	Super.Tick(deltaTime);

	if (Level.Netmode != NM_DedicatedServer)
	{
		rot = Rotation;
		rot.Roll += 16384;
		rot.Pitch -= 13384;
		SetRotation(rot);
	}
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		Damage = mpDamage;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
	}
}

defaultproperties
{
     mpDamage=90.000000
     mpAccurateRange=640
     mpMaxRange=640
     bBlood=True
     bStickToWall=True
     DamageType=shot
     AccurateRange=640
     maxRange=1280
     //spawnWeaponClass=Class'MomsKnife'
     bIgnoresNanoDefense=True
     ItemName="Knife"
     ItemArticle="Mom's"
     speed=500.000000
     MaxSpeed=500.000000
     Damage=100.000000
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Mesh=LodMesh'DeusExItems.CombatKnifePickup'
     CollisionRadius=12.650000
     CollisionHeight=0.800000
}
