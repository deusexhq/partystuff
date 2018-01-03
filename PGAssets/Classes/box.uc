//=============================================================================
// Box.
//=============================================================================
class Box extends Decoration;

#exec obj load file=..\Textures\CoreTexDetail.utx package=CoreTexDetail
var string CreatedBy;

defaultproperties
{
     bStatic=False
     bCollideWhenPlacing=True
     bMovable=False
     DrawType=DT_Mesh
     Texture=Texture'CoreTexDetail.Detail.DStone_A'
     Skin=Texture'CoreTexDetail.Detail.DStone_A'
     Mesh=LodMesh'DeusExDeco.CrateUnbreakableSmall'
     MultiSkins(0)=Texture'CoreTexDetail.Detail.DStone_A'
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideActors=True
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
