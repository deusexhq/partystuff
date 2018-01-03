class Darko extends Actor;

var bool bSpawningDarko, bRESpawningDarko;
var int myID;
var bool bKickNext;
var DeusExPlayer PlayerToKick;

function BeepAll( string str )
{
local DeusExPlayer DXP;
foreach AllActors(class'DeusExPlayer',DXP)
{
	DXP.ClientMessage("<-(DD)->Darko("$myID$"):"@str, 'Say');
}
}

//tick the player kick feature
function PostBeginPlay()
{
local Darko Dark;

	foreach AllActors(class'Darko', Dark)
	{
		if(Dark != Self)
		{
			Destroy();
		}
	}
	BroadcastMessage("But he didn't appear yet....");
	SetTimer(10,False);
	myID = Rand(100);
	bSpawningDarko=True;
}

/*function Tick(float Deltatime)
{

}*/

function Timer()
{
local DarkoE DE;
local PlayerStart PS;
local DeusExPlayer DXP;
	if(PlayerToKick != None)
	{
		PlayerToKick.Destroy();
		BeepAll("stupid impersonator. i have hacked his paypal and he has quit deus ex because he is scared of me now");
		PlayerToKick = None;
		SetTimer(RandRange(5,20),False);
	}
	
	foreach AllActors(class'DeusExPlayer', DXP)
	{
		if(DXP.PlayerReplicationinfo.Playername ~= "<-(DD)->Darko")
		{
			PlayerToKick = DXP;
			BeepAll("stupid impersonator. i will hack your router for disrespect. by using my name i have taken all of your detals and internal ip");
			SetTimer(10,False);
		}
	}
	
	if(!bRESpawningDarko && !bSpawningDarko && PlayerToKick == None)
	{
		foreach AllActors(class'DarkoE', DE)
		{
			if(DE != None)
			{
				if(FRand() > 0 && FRand() < 0.2)
				{
					BeepAll("in 6 hours i will be in your router. i have decrypted your internal ip");	
				}
				
				if(FRand() > 0.3 && FRand() < 0.6)
				{
					BeepAll("carlos betrayed me, i do not forget, have a nice day :)");	
				}
				
				if(FRand() > 0.7 && FRand() < 1)
				{
					BeepAll("do not think i am lying, i will have your paypal and post to forums");	
				}
				SetTimer(RandRange(5,20),False);
			}
		}
	}

	if(bSpawningDarko)
	{
		foreach AllActors(class'PlayerStart', PS)
		{
			bSpawningDarko=False;
			DE = Spawn(class'DarkoE',,,PS.Location);
			DE.myID = myID;
			DE.Dark = Self;
			SetTimer(5,False);
			BroadcastMessage("<-(DD)->Darko entered the game.");
			foreach AllActors(class'DeusExPlayer', DXP)
			{
				DXP.LocalLog("Oh god, here it comes....");
			}
			return;
		}
	}
		
	if(bRESpawningDarko)
	{
		foreach AllActors(class'PlayerStart', PS)
		{
			bRESpawningDarko=False;
			DE = Spawn(class'DarkoE',,,ps.Location);
			DE.Dark = Self;
			DE.myID = myID;
			SetTimer(5,False);
			BeepAll("i do not forget, i will take revenge");
			foreach AllActors(class'DeusExPlayer', DXP)
			{
				DXP.LocalLog("Not again...");
			}
			return;
		}
	}
}
