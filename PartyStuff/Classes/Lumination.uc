//=============================================================================
// It's a tarp.
//=============================================================================
class Lumination extends ChargedPickup;

function ChargedPickupBegin(DeusExPlayer Player)
{
  local Luminous lum;
   local Vector loc,X,Y,Z, v2;
   
	lum = Spawn(class'Luminous', Player,, Location,);
	if (lum != None)
	{
		v2 = Player.Location;
		v2.Z += player.collisionHeight + 50;
		lum.SetLocation(v2);
		lum.LumOwner = Player;
		lum.Lifespan = 120;
		//lum.SetBase(Self);
	}
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
     ChargeRemainingLabel="Lum readiness:"
     ItemName="Temporary Lumination Spawner"
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
     beltDescription="LUM"
     Mesh=LodMesh'DeusExItems.VialAmbrosia'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=10.000000
     Buoyancy=100.000000
}
