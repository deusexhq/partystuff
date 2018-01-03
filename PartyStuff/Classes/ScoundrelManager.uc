class ScoundrelManager extends Actor;

var DXScriptedPawn LS;
var ScoundrelMarker SM, LM;
var bool bSelectionProcess;
var PGGames myRef;
var class<DXScriptedPawn> ScoundrelClass;

function UnoSelecta()
{
local int RRR;

	foreach AllActors(class'ScoundrelMarker', LM)
	{
		RRR = Rand(10);
		
		if(RRR >= 7)
		{
			SM = LM;
			BroadcastMessage("Spawn point chosen. Target will spawn shortly.");
			SetTimer(20,False);
			return;
		}
		if(SM != None)
		{
		return;
		}
	}
	
	if(SM == None)
	{
	DosSelecta();
	}
}

function DosSelecta()
{
local int RRR;

	foreach AllActors(class'ScoundrelMarker', LM)
	{
		RRR = Rand(10);
		
		if(RRR >= 7)
		{
			SM = LM;
			BroadcastMessage("Spawn point chosen. Target will spawn shortly.");
			SetTimer(20,False);
			return;
		}
		if(SM != None)
		{
		return;
		}
	}
	
	if(SM == None)
	{
	UnoSelecta();
	}
}

function CloseGame()
{
	LS.Destroy();
	Destroy();
	BroadcastMessage("Scoundrel game forced end.");
}

function Timer()
{
	if(bSelectionProcess)
	{
		LS = spawn(ScoundrelClass,,,SM.Location,);
		BroadcastMessage("Scoundrel is in play! The Hunt Begins!");
		bSelectionProcess=False;
		SetTimer(3,True);
	}
	else
	{
		if(LS == None)
		{
			BroadcastMessage("No target in play, ending Scoundrel game.");
			myRef.bscOn=False;
			Destroy();
		}
	}
}

function BeginPlay()
{
local int C;
//Initiate
bSelectionProcess=True;
	foreach AllActors(class'ScoundrelMarker', LM)
	{
		C++;	
	}
		
	if(C == 0)
	{
		BroadcastMessage("No ScoundrelMarkers found. Cancelling startup.");
		Destroy();
	}
	if(C < 2)
	{
		BroadcastMessage("Only "$C$" ScoundrelMarkers found, MINIMUM of 3 are required. Cancelling startup.");
		Destroy();
	}
	else
	{
		BroadcastMessage(C$" ScoundrelMarkers found! Randomizing selection....");
			UnoSelecta();
	}
}

defaultproperties
{
	ScoundrelClass=class'Scoundrel'
}






