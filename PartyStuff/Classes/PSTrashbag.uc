//=============================================================================
// Trashbag.
//=============================================================================
class PSTrashbag extends Containers;

function Bump(actor Other)
{
	if(Inventory(Other) != None)
		Other.Destroy();
	if(DeusExDecoration(Other) != None)
		Other.Destroy();
}

defaultproperties
{
     bGenerateTrash=True
     HitPoints=10
     bInvincible=True
     FragType=Class'DeusEx.PaperFragment'
     bGenerateFlies=True
     ItemName="Trashbag that can eat anything"
     Mesh=LodMesh'DeusExDeco.Trashbag'
     CollisionRadius=26.360001
     CollisionHeight=26.760000
     Mass=30.000000
     Buoyancy=40.000000
}
