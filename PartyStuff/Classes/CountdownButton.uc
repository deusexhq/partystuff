//=============================================================================
// Switch1.
//=============================================================================
class CountdownButton extends Switch1;

var() int StartCount;
var() float Delay;
var() string myTitle;
var() bool bRepeatTrigger;
var() float RepeatDelay;
vaR() int				AffectRadius;
var DeusExPlayer FrobPlayer;
var int Count;
var bool bCounting;
var bool bRepeating;
var() string StartMSG;

function BeepLocal(string Str)
{
local DeusExPlayer P;

	foreach RadiusActors(class'DeusExPlayer', P, AffectRadius)
	{
			P.ClientMessage(str,'TeamSay');
	}
}

function Timer()
{
local Actor A;

	if(bRepeating)
	{
		bRepeating=False;
		if (Event != '')
		foreach AllActors(class 'Actor', A, Event)
			A.Trigger(Self, FrobPlayer);
			
			return;
	}
		if(count > 0)
		{
		BeepLocal(string(count));
		Count--;
		SetTimer(delay,false);
		return;
		}
		if(count == 0 && bCounting)
		{
			bCounting=False;
			BeepLocal(StartMSG);
			if (Event != '')
				foreach AllActors(class 'Actor', A, Event)
					A.Trigger(Self, FrobPlayer);
							if(bRepeatTrigger)
							{
								bRepeating=True;
								SetTimer(RepeatDelay,false);
							}
		}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer Player;
	FrobPlayer = DeusExPlayer(Frobber);
	
	if(!bCounting)
	{
		Count = StartCount;
		bCounting = True;
		SetTimer(delay,false);
		BeepLocal("|Cfff005Countdown Started: "$myTitle);
	}
	else
	{
		FrobPlayer.ClientMessage("|P2Already counting.");
	}
}

defaultproperties
{
    StartMSG="START"
    ItemName="Begin Countdown"
    bMovable=False
}
