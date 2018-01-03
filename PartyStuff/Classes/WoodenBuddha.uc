//=============================================================================
// HKBuddha.
//=============================================================================
class WoodenBuddha extends HongKongDecoration;
#exec obj load file=CoreTexWood.utx
defaultproperties
{
	bInvincible=True
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Wooden Buddha"
     Mesh=LodMesh'DeusExDeco.HKBuddha'
     Multiskins(0)=Texture'CoreTexWood.Wood.ClenBrwnWood_A'
     CollisionRadius=5
     CollisionHeight=8
     Mass=25.000000
     Buoyancy=5.000000
     Drawscale=0.15
}
