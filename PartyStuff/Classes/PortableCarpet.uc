//=============================================================================
// It's a tarp.
//=============================================================================
class PortableCarpet extends ChargedPickup;

#exec obj load file=..\Textures\HK_Interior.utx package=HK_Interior

// ----------------------------------------------------------------------
// ChargedPickupBegin()
// ----------------------------------------------------------------------

function ChargedPickupBegin(DeusExPlayer Player)
{
 //  local FlyingTarp CD;
   local Vector loc,X,Y,Z;
      
  Spawn(Class'FlyingCarpet',,,Player.Location + (Player.CollisionRadius+Default.CollisionRadius+30) * Vector(Player.ViewRotation) + vect(0,0,1) * 30 );
 
          

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
     ChargeRemainingLabel="Carpet readiness:"
     ItemName="Portable Carpet"
     PlayerViewOffset=(X=20.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExDeco.HKMarketTarp'
     PlayerViewScale=0.200000
     PickupViewMesh=LodMesh'DeusExDeco.HKMarketTarp'
     ThirdPersonMesh=LodMesh'DeusExDeco.HKMarketTarp'
     ThirdPersonScale=0.250000
     Charge=8
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconArmorAdaptive'
     largeIcon=Texture'DeusExUI.Icons.LargeIconArmorAdaptive'
     largeIconWidth=35
     largeIconHeight=49
     Description="Its a tarp"
     beltDescription="CARP"
     Texture=Texture'HK_Interior.Textile.HKM_Rug_04'
     Skin=Texture'HK_Interior.Textile.HKM_Rug_04'
     Mesh=LodMesh'DeusExDeco.HKMarketTarp'
     CollisionRadius=72.000000
     CollisionHeight=15.000000
     Mass=10.000000
     Buoyancy=100.000000
}
