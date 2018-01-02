//=============================================================================
// Medical Marijuana 
//=============================================================================
class MM extends DeusExPickup;
#exec obj load file=..\Textures\CoreTexPaper.utx package=CoreTexPaper
var int rechargeAmount;
var int mpRechargeAmount;

var localized String msgRecharged;
var localized String RechargesLabel;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 20;
}

function PostBeginPlay()
{
   Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
      rechargeAmount = mpRechargeAmount;
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
		local vector loc;
		local rotator rot;
		local SmokeTrail puff;
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			player.ClientMessage(Sprintf(msgRecharged, rechargeAmount));
	
			player.PlaySound(sound'MaleBurp', SLOT_None,,, 256);

			player.Energy += rechargeAmount;
			if (player.Energy > player.EnergyMax)
				player.Energy = player.EnergyMax;
				player.HealPlayer(15, False);
				
			loc = Owner.Location;
			rot = Owner.Rotation;
			loc += 2.0 * Owner.CollisionRadius * vector(Player.ViewRotation);
			loc.Z += Owner.CollisionHeight * 0.9;
			puff = Spawn(class'SmokeTrail', Owner,, loc, rot);
			if (puff != None)
			{
				puff.DrawScale = 1.0;
				puff.origScale = puff.DrawScale;
			}
			PlaySound(sound'MaleCough');
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
     rechargeAmount=5
     mpRechargeAmount=10
     msgRecharged="Recharged %d points"
     RechargesLabel="Recharges %d Energy Units"
     maxCopies=20
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Medical Marijuana"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Flare'
     PickupViewMesh=LodMesh'DeusExItems.Flare'
     ThirdPersonMesh=LodMesh'DeusExItems.Flare'
     Icon=Texture'DeusExUI.Icons.BeltIconFlare'
     largeIcon=Texture'DeusExUI.Icons.LargeIconFlare'
     largeIconWidth=24
     largeIconHeight=38
     Description="a spliff m7"
     beltDescription="MARIJUANA"
     Texture=Texture'CoreTexPaper.Paper.ClenWhitPaint_A'
     Skin=Texture'CoreTexPaper.Paper.ClenWhitPaint_A'
     Mesh=LodMesh'DeusExItems.Flare'
     MultiSkins(0)=Texture'CoreTexPaper.Paper.ClenWhitPaint_A'
     CollisionRadius=6.200000
     CollisionHeight=1.200000
     Mass=5.000000
     Buoyancy=4.000000
}
