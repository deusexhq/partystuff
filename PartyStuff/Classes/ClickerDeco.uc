//=============================================
// Clicker RPG concept
// Currently;  clicks recorded, gives EXP, levels up
// Plans; Events, Monsters, Reaction stuff
//=============================================
Class ClickerDeco extends DeusExDecoration config(ClickerDX);

struct cAcc
{
var() config string LogIP;
var() config int Clicks;
var() config int cLevel;
var() config int cEXP;
var() config string LastName;
var() config string HeroName;
var() config int LastLoginDay;
};
var() config cAcc cAccounts[150];

var config int Days;
var config int CurDay;

var config int TotalClicks;

var config bool bDebug;

function PostBeginPlay()
{
	if(CurDay != Level.Day)
	{
		CurDay = Level.Day;
		Days++;
		Log("It's a new day!", 'Clicker');
	}
	SetTimer(5,True);
}

function Timer()
{
	DebugLog("Saving config.");
	SaveConfig();
}

function GiveEXP(int AccNum, int EXPGain)
{
	cAccounts[AccNum].cEXP += EXPGain;

	if(cAccounts[AccNum].cEXP >= 100 * cAccounts[AccNum].cLevel)
	{
		cAccounts[AccNum].cEXP -= 100 * cAccounts[AccNum].cLevel;
		cAccounts[AccNum].cLevel++;
		BroadcastMessage("|P7"$cAccounts[AccNum].LastName$"'s Hero "$cAccounts[AccNum].HeroName$" is now level"@cAccounts[AccNum].cLevel);
	}
	return;
}

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer Clicker;
	local int AccNum, NewAcc;
	
	Clicker = DeusExPlayer(Frobber);
	
	if(bHasAccount(Clicker))
	{
		TotalClicks++;
		if (TotalClicks % 100 == 0)
		{
			BroadcastMessage("|P4Global clicks is now "$TotalClicks$"!!!!");
		}
		AccNum = GetPlayerAcc(Clicker);
		
		if(cAccounts[AccNum].LastLoginDay == (Days - 1))
		{
			Clicker.ClientMessage("|P7Daily bonus! + 100 EXP");
			GiveEXP(AccNum, 100);
		}
		cAccounts[AccNum].LastLoginDay = Days;
		cAccounts[AccNum].Clicks++;
		if (cAccounts[AccNum].Clicks % 100 == 0)
		{
			BroadcastMessage("|P4"$cAccounts[AccNum].LastName$"'s clicks is now "$cAccounts[AccNum].Clicks$"!!!!");
		}
		cAccounts[AccNum].LastName = GetName(Clicker);
		GiveEXP(AccNum, 1);
		Clicker.ClientMessage("Level "$cAccounts[AccNum].cLevel@cAccounts[AccNum].HeroName$": "$cAccounts[AccNum].Clicks$" clicks. ["$cAccounts[AccNum].cEXP$"/"$100 * cAccounts[AccNum].cLevel$"]");
	}
	else
	{
		for(NewAcc=0;NewAcc<150;NewAcc++)
		{
			if(cAccounts[NewAcc].LogIP == "")
			{
				DebugLog("Creating account: "$NewAcc);
				Clicker.ClientMessage("New clicker hero created. Don't stop clicking!");
				cAccounts[NewAcc].LogIP = GetIP(Clicker);
				cAccounts[NewAcc].Clicks = 0;
				cAccounts[NewAcc].cLevel = 1;
				cAccounts[NewAcc].cEXP = 0;
				cAccounts[NewAcc].LastName = GetName(Clicker);
				cAccounts[NewAcc].HeroName = "";
				return;
			}
		}
	}
}



//==============================================
//Var functions
function string GetIP(DeusExPlayer APawn)
{
    local string IP;
    IP = APawn.GetPlayerNetworkAddress();
    IP = Left(IP,InStr(IP,":"));
    DebugLog("Returned "$IP);
    return IP;
}

function string GetName(DeusExPlayer APawn)
{
	return APawn.PlayerReplicationInfo.PlayerName;
}

function bool bHasAccount(DeusExPlayer APawn)
{
	local int i;
	for(i=0;i<150;i++)
		if(cAccounts[i].LogIP == GetIP(APawn))
		{
			DebugLog("Has Account: True "$i);
			return true;
		}
		else 
		{	
			DebugLog("Has Account: False "$i);
			return false;
		}
		
}

function int GetPlayerAcc(DeusExPlayer APawn)
{
	local int i;
	for(i=0;i<150;i++)
		if(cAccounts[i].LogIP == GetIP(APawn))
		{
			DebugLog("Get Account: "$i);
			return i;
		}
}

function DebugLog(string str)
{
	if(bDebug)
		log(str, 'ClickerDebug');
}

defaultproperties
{
     cAccounts(0)=(LogIP="31.21.144.214",Clicks=17,cLevel=2,cEXP=17,lastName="Prototype",LastLoginDay=1)
     cAccounts(1)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(2)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(3)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(4)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(5)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(6)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(7)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(8)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(9)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(10)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(11)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(12)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(13)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(14)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(15)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(16)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(17)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(18)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(19)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     cAccounts(20)=(LogIP="192.168.0.17",cLevel=1,lastName="Kaiser")
     Days=1
     CurDay=9
     TotalClicks=17
     bInvincible=True
     ItemName="The Clicker"
     bPushable=False
     Physics=PHYS_None
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex6'
     Skin=Texture'DeusExDeco.Skins.AlarmLightTex6'
     DrawScale=1.500000
     CollisionRadius=45.200001
     CollisionHeight=32.000000
     bBlockPlayers=False
}
