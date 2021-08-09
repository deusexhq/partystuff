//=============================================================================
// Multitool.
//=============================================================================
class PSComputerHandheld extends DeusExPickup;

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local DeusExPlayer player, hitplayer;
		local scriptedpawn hitpawn;
		local dxScriptedPawn hitpawn2;
		local Actor       hitActor;
		local Vector      hitLocation, hitNormal;
		local Vector      position, line;
		local float Dist;
		local PSComputer psc;
		local bool bFound;
		
		Super.BeginState();
		player = DeusExPlayer(Owner);
		
		foreach AllActors(class'PSComputer',psc)
			if(PSC.pgUser == player)
			{
				bFound=True;
				PSC.Frob(player, Self);
			}
		
		if(!bFound)	
			player.clientmessage("No computer found... Be sure to successfully login to one to register it.");
		GotoState('DeActivated');
	}
Begin:
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 1;
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     maxCopies=1
     bActivatable=True
     ItemName="Handheld Computer"
     PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MultitoolPOV'
     PickupViewMesh=LodMesh'DeusExItems.Multitool'
     ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
     M_Activated=" connecting to network..."
     largeIcon=Texture'DeusExUI.Icons.LargeIconMultitool'
     largeIconWidth=28
     largeIconHeight=46
     Description=""
     beltDescription="COMPUTER"
     Mesh=LodMesh'DeusExItems.Multitool'
     CollisionRadius=4.800000
     CollisionHeight=0.860000
     Mass=20.000000
     Buoyancy=10.000000
}
