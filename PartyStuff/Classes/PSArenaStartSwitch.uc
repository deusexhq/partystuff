//=============================================================================
//.
//=============================================================================
class PSArenaStartSwitch extends Switch2;

var() name SpawnTag, ArenaZoneTag;
var bool bPSActive;

function Frob(Actor Frobber, Inventory frobWith)
{
	local PSArenaZone PZ;
	local deusexplayer dxp;
	dxp = DeusExPlayer(Frobber);
	
	if(!bPSActive)
	{
		dxp.ClientMessage("Button disabled..");
		return;
	}
	
	foreach AllActors(class'PSArenaZone', PZ)
	{
		if(PZ.Tag == ArenaZoneTag)
		{
			PZ.BeginMatch();
			bPSActive=False;
		}
	}
}

defaultproperties
{
     bPSActive=True
     ItemName="Begin the battle!"
}
