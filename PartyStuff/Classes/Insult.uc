//=============================================
// Insult Actor
//=============================================
Class Insult extends DeusExDecoration config(PartyStuff);
//RUN A CHECK FOR THE RANDOMIZING TO SEE IF THE LAST SPOT IS FILLED
//IF IT IS, DONT RUN THE CHECK FOR WHATS THE HIGHEST
//--MIGHT FIX THE RANDOMIZING THE LAST SLOT FULLNESS GLITCH
var config string actions[20], objects[20];
var config float frobDelay;

var deusexplayer victarray[16];
var bool bDisableFrob;

function PreBeginPlay()
{
local Insult ins;
local int i;
	foreach AllActors(class'Insult', ins)
		i++;
	
	if(i > 3)
	{
			Log("Insulter destroyed due to limits. Max 3 due to spamming.");
		Destroy();
	}
		
}
function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer P, vict, finalvict;
	local int iact, iobj, maxact, maxobj, k, j, l, v;
	local string act, obj, complete;
	local bool bSelf;
	
	P=DeusExPlayer(Frobber);
	
	if(!bDisableFrob)
	{
		Super.Frob(frobber, frobwith);
		
		if(objects[19] == "")
		{
			for(j=0;j<20;j++)
			{
				if(objects[j] == "" && j <= 19)
				{
					maxobj = j;
					break;
				}
			}
		}
		else
		{
			maxobj = 20;
		}
		
		if(actions[19] == "")
		{
			for(k=0;k<20;k++)
			{
				if(actions[k] == "" && k <= 19)
				{
					maxact = k;
					break;
				}			
			}
		}
		else
		{
			maxact = 20;
		}
		
		//iact = Rand(maxact);
		//iobj = Rand(maxobj);
		foreach allactors(Class'deusexplayer', vict)
		{
			if(victarray[l] == none)
			{
				Victarray[l] = vict;
			}
			l++;
		}
		
		for(l=0;l<16;l++)
		{
			if(victarray[l] == None)
			{
				v = l;
				break;
			}
		}
		
		finalvict = victarray[Rand(v)];
		act = actions[Rand(maxact)];
		obj = objects[Rand(maxobj)];
		
		if(finalvict == P)
		{
			bSelf=True;
		}
		
		if(FRand() < 0.5)
		{
			BroadcastMessage(finalvict.playerreplicationinfo.playername$" is "$obj);
		}
		else
		{
			if(!bSelf)
			{
				BroadcastMessage(p.playerreplicationinfo.playername@act@finalvict.playerreplicationinfo.playername@"with"@obj);
			}
			else
			{
				BroadcastMessage(p.playerreplicationinfo.playername@act@"themself with"@obj);
			}
		}
		
		for(l=0;l<16;l++)
		{
			if(victarray[l] != None)
			{
				victarray[l] = None;
			}
		}
		
		bDisableFrob=True;
		SetTimer(frobDelay,False);
	}
}

function Timer()
{
	bDisableFrob=False;
}

defaultproperties
{
     actions(0)="slapped"
     actions(1)="smothered"
     actions(2)="fucked"
     actions(3)="tickled"
     actions(4)="smashed"
     actions(5)="bit"
     actions(6)="twatted"
     actions(7)="rekt"
     actions(8)="engulfed"
     actions(9)="morphed"
     actions(10)="terminated"
     actions(11)="infused"
     actions(12)="expanded"
     actions(13)="punched"
     actions(14)="shot"
     actions(15)="spit on"
     actions(16)="spilled"
     actions(17)="slashed"
     actions(18)="wasted"
     actions(19)="prodded"
     objects(0)="a motherfucking truck"
     objects(1)="a big fucking fish"
     objects(2)="a dong"
     objects(3)="a fucking huge dong"
     objects(4)="a darko machine"
     objects(5)="a turd"
     objects(6)="some kind of giant bitch"
     objects(7)="a booby trap"
     objects(8)="a mouldy vagina"
     objects(9)="a fat woman"
     objects(10)="a pussy cat"
     objects(11)="a pigeon"
     objects(12)="toilet paper"
     objects(13)="a knuckle duster"
     objects(14)="a bowl of noodles"
     objects(15)="a bowl of pasta"
     objects(16)="an oriental daily news!"
     objects(17)="a maggie chow"
     objects(18)="a chicken leg"
     objects(19)="an octopus dick"
     frobDelay=3.000000
     bInvincible=True
     ItemName="The Glowing Orb of Insultery"
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
