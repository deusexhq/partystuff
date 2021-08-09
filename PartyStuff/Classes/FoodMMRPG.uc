//=============================================================================
// BioelectricCell.
//=============================================================================
class FoodMMRPG extends DeusExPickup;

var int rechargeAmount;

var localized String msgRecharged;
var localized String RechargesLabel;

var Sound EatSound;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

//MainMan: NO, ph00'!
	// If this is a netgame, then override defaults
//	if ( Level.NetMode != NM_StandAlone )
//		MaxCopies = 5;
}

function PostBeginPlay()
{
   Super.PostBeginPlay();
}

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
		{
			//player.ClientMessage(Sprintf(msgRecharged, rechargeAmount));
	
			//player.PlaySound(EatSound, SLOT_None,,, 256);


			player.HealPlayer(rechargeamount, True);

			//player.Energy += rechargeAmount;
			//if (player.Energy > player.EnergyMax)
			//	player.Energy = player.EnergyMax;
		}

		UseOnce();
	}
Begin:
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local string str;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	winInfo.AppendText(Sprintf(RechargesLabel, RechargeAmount));

	// Print the number of copies
	str = CountLabel @ String(NumCopies);
	winInfo.AppendText(winInfo.CR() $ winInfo.CR() $ str);

	return True;
}

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------


function DropFrom(vector StartLocation)
{
	LifeSpan = 5.0;
	Super.DropFrom(StartLocation);
}


function BecomeItem()
{
	LifeSpan = 0.0;
	Super.BecomeItem();
}

defaultproperties
{
     rechargeAmount=25
     msgRecharged="Replenished %d health points"
     RechargesLabel="Replenished %d health points"
     maxCopies=30
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="ERROR- T3h D3FAULT"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.BioCell'
     PickupViewMesh=LodMesh'DeusExItems.BioCell'
     ThirdPersonMesh=LodMesh'DeusExItems.BioCell'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconBioCell'
     M_Activated=" eaten"
     largeIcon=Texture'DeusExUI.Icons.LargeIconBioCell'
     largeIconWidth=44
     largeIconHeight=43
     beltDescription="OMG LOL, IT's TEH HAWTZORZ"
     Mesh=LodMesh'DeusExItems.BioCell'
     CollisionRadius=4.700000
     CollisionHeight=0.930000
     Mass=5.000000
     Buoyancy=4.000000
}
