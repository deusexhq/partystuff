//=============================================================================
// PlaySound
//=============================================================================
class PlaySoundswitch extends Switch2;

var bool bOn;
var() bool bPlayToAll;
var() sound sSound;
var() float sPitch;

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer DXP;
	Super.Frob(Frobber, frobWith);
	
	if (bOn)
	{
		if(bPlayToAll)
		{
			foreach Allactors(class'DeusexPlayer',DXP)
				DXP.PlaySound(sSound,SLOT_None);
		}
		else
		{
			PlaySound(sSound,SLOT_None);
		}
		PlayAnim('Off');
	}
	else
	{
		if(bPlayToAll)
		{
			foreach Allactors(class'DeusexPlayer',DXP)
				DXP.PlaySound(sSound,SLOT_None);
		}
		else
		{
			PlaySound(sSound,SLOT_None);
		}
		PlayAnim('On');
	}

	bOn = !bOn;
}

defaultproperties
{
     ItemName="Sound Switch"
}
