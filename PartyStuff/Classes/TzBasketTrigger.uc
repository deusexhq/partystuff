//=============================================================================
// TzBasketTrigger.
//=============================================================================
class TzBasketTrigger extends Trigger;

#exec obj load file=..\System\DeusExSounds.u package=DeusExSounds

function Touch(actor Other)
{
	local Actor DXPO;
	DXPO = Other.Owner;
	if (Other.IsA('BasketballMP')&& DeusExPlayer(DXPO) != None && !BasketballMP(Other).bAlreadyScored)
	{
		BasketballMP(Other).bAlreadyScored = True;
	}
}

defaultproperties
{
}
