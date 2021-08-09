//=============================================================================
//.
//=============================================================================
class PSTeleSwitch extends Switch2;

var() name TeleporterTag;
var() string DisableString;
var() bool bAdmins;
var() bool bUseFX;

var() enum eChk
{
	CH_Admin,
	CH_Staff,
	CH_VIP,
	CH_None
} CheckClass;

function TeleportFX(DeusExPlayer TPGuy, vector Loc)
{
	local psTeleRing1 TR, TROther;
	
	TPGuy.bMovable=False;
	TR = Spawn(class'psTeleRing1',,,TPGuy.Location);
	TR.Target = TPGuy;
	TR.TPLoc = Loc;
	
	TROther = Spawn(class'psTeleRing1',,,Loc);
	TROther.OriginLoc = Loc;
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local deusexplayer dxp;
	local inventory inv;
	local bool bFound;
	
	dxp = DeusExPlayer(Frobber);
	
	if(DisableString != "")
	{
		dxp.ClientMessage(disableString);
		return;
	}
	
	if(bAdmins && dxp.bAdmin)
	{
		PlaySound(sound'LogNoteAdded');
		dxp.ClientMessage("|P3Admin confirmed!");
		bFound=True;
		DoTP(DXP);
	}
	if(!bFound && CheckClass == CH_Admin)
	{
		foreach AllActors(class'Inventory', Inv)
		{
			if (Inv.Owner == dxp)
			{
				if (Inv.IsA('AdminCard')) 
				{
					  PlaySound(sound'LogNoteAdded');
					  dxp.ClientMessage("|P3Admin confirmed!");
					  bFound=True;
					  DoTP(DXP);
				}
			}
		}
	}
	
	if(!bFound && CheckClass == CH_Staff)
	{
		foreach AllActors(class'Inventory', Inv)
		{
			if (Inv.Owner == dxp)
			{
				if (Inv.IsA('AdminCard')) 
				{
					  PlaySound(sound'LogNoteAdded');
					  dxp.ClientMessage("|P3Admin confirmed!");
					  bFound=True;
					  DoTP(DXP);
				}
				if (Inv.IsA('StaffCard')) 
				{
					  PlaySound(sound'LogNoteAdded');
					  dxp.ClientMessage("|P3Staff confirmed!");
					  bFound=True;
					  DoTP(DXP);
				}
			}
		}
	}
	if(!bFound && CheckClass == CH_VIP)
	{
		foreach AllActors(class'Inventory', Inv)
		{
			if (Inv.Owner == dxp)
			{
				if (Inv.IsA('AdminCard')) 
				{
					  PlaySound(sound'LogNoteAdded');
					  dxp.ClientMessage("|P3Admin confirmed!");
					  bFound=True;
					  DoTP(DXP);
				}
				if (Inv.IsA('StaffCard')) 
				{
					  PlaySound(sound'LogNoteAdded');
					  dxp.ClientMessage("|P3Staff confirmed!");
					  bFound=True;
					  DoTP(DXP);
				}
				if (Inv.IsA('VIPCard')) 
				{
					  PlaySound(sound'LogNoteAdded');
					  dxp.ClientMessage("|P3VIP confirmed!");
					  bFound=True;
					  DoTP(DXP);
				}
			}
		}
	}
	
	if(!bFound && CheckClass != CH_None)
	{
		DXP.ClientMessage("Access denied.");
	}
	
	if(CheckClass == CH_None)
	{
		DoTP(DXP);
	}
}

function DoTP(DeusExPlayer DXP)
{
	local Teleporter TP;
	local inventory inv;
	local bool bFound;
	local PSAfterEffect PSAE;
	
	if(!bUseFX)
	{
		foreach AllActors(class'Teleporter', TP)
		{
			if(TP.Tag == TeleporterTag)
			{
				PSAE = Spawn(class'PSAfterEffect');
				PSAE.AttachToPlayer(dxp);
				DXP.SetCollision(false, false, false);
				DXP.bCollideWorld = true;
				DXP.GotoState('PlayerWalking');
				DXP.SetLocation(TP.Location);
				DXP.SetCollision(true, true , true);
				DXP.SetPhysics(PHYS_Walking);
				DXP.bCollideWorld = true;
				DXP.GotoState('PlayerWalking');
				DXP.ClientReStart();	
				//TeleportFX(DXP, TP.Location);
			}
		}
	}
	else
	{
		foreach AllActors(class'Teleporter', TP)
		{
			if(TP.Tag == TeleporterTag)
			{
				TeleportFX(DXP, TP.Location);
			}
		}
		
	}
}

defaultproperties
{
     ItemName="Teleporter"
}
