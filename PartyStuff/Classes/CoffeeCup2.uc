//=============================================================================
// CoffeeCup.
//=============================================================================
class CoffeeCup2 extends DeusExPickup;

var int rechargeAmount;
var int mpRechargeAmount;

var localized String msgRecharged;
var localized String RechargesLabel;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 15;
}

function PostBeginPlay()
{
   Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
      rechargeAmount = mpRechargeAmount;
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
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
			player.ClientMessage(Sprintf(msgRecharged, rechargeAmount));
	
			player.PlaySound(sound'MaleBurp', SLOT_None,,, 256);

			player.Energy += rechargeAmount;
			if (player.Energy > player.EnergyMax)
				player.Energy = player.EnergyMax;
				player.HealPlayer(60, False);
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
     rechargeAmount=5
     mpRechargeAmount=50
     msgRecharged="Recharged %d points"
     RechargesLabel="Recharges %d Energy Units"
     maxCopies=15
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Hot Coffee"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'Endemia.CoffeeCup'
     PickupViewMesh=LodMesh'Endemia.CoffeeCup'
     ThirdPersonMesh=LodMesh'Endemia.CoffeeCup'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'Endemia.Icons.BeltIconCoffeeCup'
     largeIcon=Texture'Endemia.Icons.LargeIconCoffeeCup'
     largeIconWidth=24
     largeIconHeight=38
     Description="A A tumbler filled with a warm, black coffee without sugar.|n|n<UNATCO OPS FILE NOTE JR289-VIOLET> The cafeïn seems to possess certain stimulating power on the nano-entities. Several tests are in progress on this subject. -- Jaime Reyes <END NOTE>"
     beltDescription="COFFEE"
     Mesh=LodMesh'Endemia.CoffeeCup'
     CollisionRadius=3.000000
     CollisionHeight=4.500000
     Mass=5.000000
     Buoyancy=4.000000
}
