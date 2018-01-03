//=============================================================================
// TzBasketExitTrigger.
//=============================================================================
class TzBasketExitTrigger extends Trigger;

function Touch(actor Other)
{
	local Actor DXPO;
	DXPO = Other.Owner;
	if (Other.IsA('BasketballMP'))
	{
		if(BasketballMP(Other).bAlreadyScored)
		{
			BasketballMP(Other).bAlreadyScored = False;
			DeusExPlayer(DXPO).BroadcastMessage("|c33CCFF"@DeusExPlayer(DXPO).PlayerReplicationInfo.Playername@"has scored a point in basketball!");
		DeusExPlayer(DXPO).PlayerReplicationInfo.Score += 1;
		DeusExPlayer(DXPO).PlayerReplicationInfo.Streak += 1;
		PlaySound(Sound'DeusExSounds.UserInterface.LogSkillPoints', SLOT_None,2,,512);
		}

	}
}

defaultproperties
{
}
