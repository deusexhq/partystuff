//=============================================================================
//.
//=============================================================================
class PSArenaEntrySwitch extends Switch2;

var() name SpawnTag;
var bool bPSActive;

function Frob(Actor Frobber, Inventory frobWith)
{
	local PSArenaSpawner PSA;
	local deusexplayer dxp;
	dxp = DeusExPlayer(Frobber);
	
	if(!bPSActive)
	{
		dxp.ClientMessage("Not allowed to enter.");
		return;
	}
	foreach AllActors(class'PSArenaSpawner', PSA)
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
     ItemName="Enter the arena!"
}
