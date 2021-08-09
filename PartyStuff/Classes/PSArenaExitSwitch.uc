//=============================================================================
//.
//=============================================================================
class PSArenaExitSwitch extends Switch2;

var() name SpawnTag;
var bool bPSActive;

function Frob(Actor Frobber, Inventory frobWith)
{
	local PSArenaExit PSA;
	local deusexplayer dxp;
	dxp = DeusExPlayer(Frobber);
	
	if(!bPSActive)
	{
		dxp.ClientMessage("Not allowed to leave.");
		return;
	}
	
	foreach AllActors(class'PSArenaExit', PSA)
	{
		if(PSA.Tag == SpawnTag)
		{
				DXP.SetCollision(false, false, false);
				DXP.bCollideWorld = true;
				DXP.GotoState('PlayerWalking');
				DXP.SetLocation(PSA.location);
				DXP.SetCollision(true, true , true);
				DXP.SetPhysics(PHYS_Walking);
				DXP.bCollideWorld = true;
				DXP.GotoState('PlayerWalking');
				DXP.ClientReStart();	
		}
	}
}

defaultproperties
{
     bPSActive=True
     ItemName="Exit the arena!"
}
