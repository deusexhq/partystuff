//=============================================================================
// ComputerPersonal.
//=============================================================================
class PSKeypad extends DeusExDecoration;

var() string Password;

function bool ChkPass(deusexplayer p, string inputPassword)
{
	local string mailstring, sendstring, target, msg;
	local int mailint,i, b;
	local actor a;
	local bool bSkipPass;
	local PSKR f;
		
	if(inputPassword != Password)
	{
		xAlert(p, "Alert","Access denied.");
		return false;
	}
	
	if (Event != '')
			foreach AllActors(class 'Actor', A, Event)
				A.Trigger(Self, P);
	
	xAlert(p, "Alert","|P3Access granted.");
	
}

function xAlert(deusexplayer p, string title, string msg)
{
	local PSKR f;
	foreach AllActors(class'PSKR', f)
				if(f.Flagger == p)
					f.cAlert(title, msg);
}

function Frob(actor frobber, inventory frobwith)
{
	local DeusExPlayer P;
	local PSKR newlogin, f;
	local bool bFound;
	
	P = DeusExPlayer(frobber);
	P.PlaySound(sound'Auth',,,, 256);
	
	foreach AllActors(class'PSKR', f)
		if(f.Flagger == P)
		{
			f.Flagger = P;
			f.ac = self;
			f.SetTimer(0.5,false);
			bFound=True;
		}
			
	if(!bFound)
	{
		newlogin = Spawn(class'PSKR');
		newlogin.Flagger = P;
		newlogin.ac = self;
		newlogin.SetTimer(0.5,false);
	}
}

defaultproperties
{
     ItemName="Password Entry Device"
 Mesh=LodMesh'DeusExDeco.TAD'
     CollisionRadius=7.400000
     CollisionHeight=2.130000
     Physics=PHYS_None
     bPushable=False
     bInvincible=True
}
