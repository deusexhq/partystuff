//=============================================================================
// FlagPole.
//=============================================================================
class WoodenBird extends DeusExDecoration;
#exec obj load file=CoreTexWood.utx
defaultproperties
{
	bInvincible=True
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Wooden Bird"
     Mesh=LodMesh'DeusExCharacters.Seagull'
     Multiskins(0)=Texture'CoreTexWood.Wood.ClenBrwnWood_A'
     CollisionRadius=10
     CollisionHeight=3.6
     Drawscale=0.6
     Mass=5.000000
     Buoyancy=30.000000
}
