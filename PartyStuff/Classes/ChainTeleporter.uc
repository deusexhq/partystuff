//=============================================
// RestPoint
//=============================================
Class ChainTeleporter extends DeusExDecoration;

var bool bCooldown;
var() float Cooldown;
var float LastLaunchTime;
var int ChainNum;
var deusexplayer returntoplayer;
var int baseNum;
var bool bDoneSetup;

replication
{
	reliable if ( Role < ROLE_Authority )
		LastLaunchTime, Cooldown;
}

function PostBeginPlay()
{
	//Moved the setup from here to a randomized timer, since DX triggers them all at once at map start....
	SetTimer(Rand(15),False);
}

function Timer()
{
	local TCT h;
	local ChainTeleporter CT;
	local int T;
	
	if(!bDoneSetup)
	{
		bDoneSetup=True;
		if(ChainNum == 0)
		{
			foreach AllActors(class'ChainTeleporter',CT)
				if(CT != Self && CT.bDoneSetup)
					T++;

			log(T$" chains. Chain ident is"@T+1, 'ChainTeleporter');
			ChainNum = T+1;
		}
	}
	else
	{
		if(ReturntoPlayer != None)
		{
			Destroy();
			h=Spawn(class'tct', Self,, Location, Rotation);
			h.Frob(returntoplayer,None);
			//h.bInObjectBelt = True;
			h.Destroy();
			
		}
		bCooldown=False;
		Texture=Texture'DeusExDeco.Skins.AlarmLightTex4';
		LightHue=70;
	}
}

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer P;
	local ChainTeleporter CT;
	local bool bFound;
	P=DeusExPlayer(Frobber);
	
			if(Cooled())
			{
				foreach AllActors(class'ChainTeleporter',CT)
				{
					if(CT.ChainNum == ChainNum+1)
					{
						P.SetLocation(CT.Location);
						bFound=True;
					}
				}
				if(!bFound)
				{
					foreach AllActors(class'ChainTeleporter',CT)
					{
						if(CT.ChainNum == baseNum)
						{
							P.SetLocation(CT.Location);
							bFound=True;
						}
					}
				}
				if(bFound)
				{
				LastLaunchTime = Level.TimeSeconds;
				bCooldown=True;
				Texture=Texture'DeusExDeco.Skins.AlarmLightTex2';
				LightHue=0;
				SetTimer(Cooldown,false);
				}
			}
			else
			{
				P.ClientMessage("Teleporter is cooling down, please wait "$int(Cooldown - (Level.TimeSeconds - lastLaunchTime))$" seconds.");
			}
}


function bool Cooled()
{	
	return (Level.TimeSeconds - lastLaunchTime > Cooldown);
}

defaultproperties
{
	baseNum=1
     Cooldown=5.000000
     bInvincible=True
     ItemName="Chain Teleporter"
     bPushable=False
     Physics=PHYS_None
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex4'
     Skin=Texture'DeusExDeco.Skins.AlarmLightTex6'
     DrawScale=1.500000
     CollisionRadius=45.200001
     CollisionHeight=32.000000
     bBlockPlayers=False
     LightType=LT_Steady
     LightBrightness=120
     LightHue=70
     LightSaturation=100
     LightRadius=10
}
