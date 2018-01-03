//=============================================================================
// It's a tarp.
//=============================================================================
class TLItem extends ChargedPickup;

// ----------------------------------------------------------------------
// ChargedPickupBegin()
// ----------------------------------------------------------------------

function ChargedPickupBegin(DeusExPlayer Player)
{
  local TLauncher CD;
   local Vector loc,X,Y,Z;
   
   CD = Spawn(Class'TLauncher',,,Player.Location + (Player.CollisionRadius+Default.CollisionRadius+30) * Vector(Player.ViewRotation) + vect(0,0,1) * 30 );
	CD.TM=T_Companion;
	Super.ChargedPickupBegin(Player);
	
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) || (BeltSpot == 0) );
}

function UsedUp()
{
	local DeusExPlayer Player;

	if ( Pawn(Owner) != None )
	{
		bActivatable = false;
		
	}
	Player = DeusExPlayer(Owner);

	if (Player != None)
	{
		if (Player.inHand == Self)
			ChargedPickupEnd(Player);
	}

	Destroy();
}

defaultproperties
{
     ActivateSound=Sound'DeusExSounds.Augmentation.CloakUp'
     DeActivateSound=None
     ChargeRemainingLabel="TL readiness:"
     ItemName="Travel Bomber Spawner"
     PlayerViewOffset=(X=20.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
     Charge=8
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconVialAmbrosia'
     largeIcon=Texture'DeusExUI.Icons.LargeIconVialAmbrosia'
     largeIconWidth=35
     largeIconHeight=49
     Description="s"
     beltDescription="TRAVEL"
     Mesh=LodMesh'DeusExItems.VialAmbrosia'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=10.000000
     Buoyancy=100.000000
}
