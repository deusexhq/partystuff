//=============================================================================
// Switch1.
//=============================================================================
class ClassCheckButton extends ClassCheckScanner;

var bool bOn;


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
   if (bOn)
   {
      PlaySound(sound'Switch4ClickOff');
      PlayAnim('Off');
   }
   else
   {
      PlaySound(sound'Switch4ClickOn');
      PlayAnim('On');
   }

   bOn = !bOn;
}

defaultproperties
{
     ItemName="Checker Switch"
     Mesh=LodMesh'DeusExDeco.Switch1'
     CollisionRadius=2.630000
     CollisionHeight=2.970000
     Mass=10.000000
}
