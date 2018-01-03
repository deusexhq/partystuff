//=============================================================================
// VortexGen
//=============================================================================
class VortexGen expands DeusExPickup;

simulated state Activated
{
	function Activate()
	{		

	}
	
	function BeginState()
	{		
		spawn(class'Vortex',Owner,,Owner.Location,DeusExPlayer(Owner).ViewRotation);

		GotoState('DeActivated');
		UseOnce();
		
	}
	
	Begin:
}

defaultproperties
{
     maxCopies=5
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Vortex Generator"
     ItemArticle="an"
     PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MultitoolPOV'
     PickupViewMesh=LodMesh'DeusExItems.Multitool'
     ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
     largeIcon=Texture'DeusExUI.Icons.LargeIconMultitool'
     Description="This Tool generates a temporary powerful gravitational vortex, which will suck every human or robot within its reach.|n|n<ULTIMATE OPS FILE NOTE AJ012-BLACK> Before creating this vortex, be sure your allies are distant enough. The vortex is only able to identify its owner, therefore he is the only one who can stand unaffected near it. -- Deadalus08 <END NOTE>"
     beltDescription="VORTEX GEN"
     Mesh=LodMesh'DeusExItems.Multitool'
     CollisionRadius=4.800000
     CollisionHeight=0.860000
}
