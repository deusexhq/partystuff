//=============================================================================
// Switch1.
//=============================================================================
class ClassCheckScanner extends DeusExDecoration;

enum eChk
{
	CH_Admin,
	CH_Staff,
	CH_VIP
};

var(CheckClass) eChk CheckClass;

var(CheckClass) bool bAdminOverride;

function Frob(Actor Frobber, Inventory frobWith)
{
	local bool bFound;
      local Inventory Inv;
	  local string CHKR;
      local DeusExPlayer Player;
      Player = DeusExPlayer(Frobber);
	  bFound=False;
	  
	  if(bAdminOverride && Player.bAdmin)
	  {
			Player.ClientMessage("|P4Access Check Level: |P2-----");
		  Player.ClientMessage("|P2Administrator override activated.");
		  Super.Frob(Frobber, frobWith);
		  return;
	  }
	  if(CheckClass == CH_Admin)
			CHKR = "Admin";
	  if(CheckClass == CH_Staff)
			CHKR = "Staff";
	  if(CheckClass == CH_VIP)
			CHKR = "VIP";

			
	  	  Player.ClientMessage("|P4Access Check Level: "$CHKR);
		  Player.ClientMessage("|P4Item must be in inventory. Checking... ");
            foreach AllActors(class'Inventory', Inv)
            {
                if (Inv.Owner == Player)
				{
					if(CheckClass==CH_Admin)
					{
						if (Inv.IsA('AdminCard')) 
						{
						      PlaySound(sound'LogNoteAdded');
							  Player.ClientMessage("|P3Admin confirmed!");
							  bFound=True;
							Super.Frob(Frobber, frobWith);
						}
					}
					if(CheckClass==CH_Staff)
					{						
						if (Inv.IsA('AdminCard')) 
						{
						      PlaySound(sound'LogNoteAdded');
							  Player.ClientMessage("|P3Admin confirmed for Staff scan!");
							  bFound=True;
							Super.Frob(Frobber, frobWith);
						}
						
						if (Inv.IsA('StaffCard') && !bFound) 
						{
						      PlaySound(sound'LogNoteAdded');
							  Player.ClientMessage("|P3Staff confirmed!");
							  bFound=True;
							Super.Frob(Frobber, frobWith);
						}
					}
					if(CheckClass==CH_VIP)
					{
						if (Inv.IsA('AdminCard')) 
						{
						      PlaySound(sound'LogNoteAdded');
							  Player.ClientMessage("|P3Admin confirmed for VIP scan!");
							  bFound=True;
							Super.Frob(Frobber, frobWith);
						}
						
						if (Inv.IsA('StaffCard') && !bFound) 
						{
						      PlaySound(sound'LogNoteAdded');
							  Player.ClientMessage("|P3Staff confirmed for VIP scan!");
							  bFound=True;
							Super.Frob(Frobber, frobWith);
						}
						if (Inv.IsA('VIPCard') && !bFound)  
						{
						      PlaySound(sound'LogNoteAdded');
							  Player.ClientMessage("|P3VIP confirmed!");
							  bFound=True;
							Super.Frob(Frobber, frobWith);
						}
					}
				}	
			}
			
			if(!bFound)
			{
				Player.ClientMessage("|P2Access card not found!");
			}
}

defaultproperties
{
     bInvincible=True
     ItemName="Scanner"
     bPushable=False
     Physics=PHYS_None
     Texture=Texture'DeusExItems.Skins.DataCubeTex2'
     Mesh=LodMesh'DeusExItems.DataCube'
     CollisionRadius=7.000000
     CollisionHeight=1.270000
     Buoyancy=12.000000
}
