//=============================================================================
// VialAmbrosia.
//=============================================================================
class VialGrow extends DeusExPickup;

var bool bOn;

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local DeusExPlayer player;
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)

		bOn = !bOn;
		
		if(bOn)
			DeusExPlayer(Owner).ClientMessage("Grow activated.");
		else
			DeusExPlayer(Owner).ClientMessage("Grow de-activated.");
	GotoState('DeActivated');
	}
Begin:
}

defaultproperties
{
     maxCopies=1
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Grow Vial"
     ItemArticle="an"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconVialAmbrosia'
     M_Activated=""
     largeIcon=Texture'DeusExUI.Icons.LargeIconVialAmbrosia'
     largeIconWidth=18
     largeIconHeight=44
     Description="The only known vaccine against the 'Gray Death.' Unfortunately, it is quickly metabolized by the body making its effects temporary at best."
     beltDescription="GROW"
     Mesh=LodMesh'DeusExItems.VialAmbrosia'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=2.000000
     Buoyancy=3.000000
}
