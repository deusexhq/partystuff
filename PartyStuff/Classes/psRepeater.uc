//String repeater.
class psRepeater extends PGActors;

var() string RepeaterString;
var() int RepeaterTimes;
var int TimesRun;
var() string psRef;

function Engage(string Stringz, int Timerz, int Repeatz)
{
	SetTimer(float(Timerz),False);
}

function BeepToAll(string str)
{
	local DeusExPlayer DXP;
	
	foreach allactors(class'DeusExPlayer',DXP)
	{
		DXP.ClientMessage(str,'Say');
	}
}

function Timer()
{
	if(TimesRun != RepeaterTimes)
	{
		BeepToAll(RepeaterString);
		TimesRun++;
	}
	else
	{
		BeepToAll(RepeaterString);
		Destroy();
	}
}

defaultproperties
{
RepeaterTimes=5
}

