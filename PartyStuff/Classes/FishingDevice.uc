//=============================================================================
// Fishing
//=============================================================================
class FishingDevice expands DeusExPickup;

var FishingBait Bait;
var FishingBait2 Lure;

var int Catches;
var int Stage; // 0 - Idle, 1 - Casting (Bait is out, not landed), 2 - Lure is out

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
		if(Stage == 0)
		{
			if(Bait == None)
			{
				Bait = spawn(class'FishingBait',Owner,,Owner.Location,DeusExPlayer(Owner).Rotation);
				Bait.Velocity = Velocity + 0.7 * Owner.Velocity;
				Bait.MainDev = Self;
				Stage = 1;
				Player.ClientMessage("Bait cast.");
				return;
			}
		}
		
		if(Stage == 1)
		{
			if(Bait != None)
			{
				Bait.Destroy();
				Player.ClientMessage("Bait recalled.");
				Stage = 0;
				return;
			}
		}
		
		if(Stage == 2)
		{
			if(Lure != None)
			{
				if(Lure.bHasCatch)
				{
					Lure.PingCatch();
				}
				else
				{
					Player.ClientMessage("Lure recalled.");
					Lure.Destroy();
					Stage = 0;
				}
			}
		}
		
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
     ItemName="Handheld Fishing Device"
     PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MultitoolPOV'
     PickupViewMesh=LodMesh'DeusExItems.Multitool'
     ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
     M_Activated=""
     largeIcon=Texture'DeusExUI.Icons.LargeIconMultitool'
     largeIconWidth=28
     largeIconHeight=46
     Description=""
     beltDescription="FISHING"
     Mesh=LodMesh'DeusExItems.Multitool'
     CollisionRadius=4.800000
     CollisionHeight=0.860000
     Mass=20.000000
     Buoyancy=10.000000
}
