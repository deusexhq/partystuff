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
     DrawScale=0.600000
     MultiSkins(0)=Texture'CoreTexWood.Wood.ClenBrwnWood_A'
     CollisionRadius=10.000000
     CollisionHeight=3.600000
     Mass=5.000000
     Buoyancy=30.000000
}
