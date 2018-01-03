//=============================================================================
// StaffCard.
//=============================================================================
class StaffCard expands DeusExPickup;


// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     bCanHaveMultipleCopies=True
     ItemName="Staff Card"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Credits'
     PickupViewMesh=LodMesh'DeusExItems.Credits'
     ThirdPersonMesh=LodMesh'DeusExItems.Credits'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconCredits'
     beltDescription="Staff Pass"
     Mesh=LodMesh'DeusExItems.Credits'
     MultiSkins(0)=Texture'DeusExUI.UserInterface.ComputerLogonLogoArea51'
     CollisionRadius=7.000000
     CollisionHeight=0.550000
     Mass=2.000000
     Buoyancy=3.000000
}
