//=============================================
// RestPoint
//=============================================
Class RestPoint extends DeusExDecoration;

var DeusExPlayer ConfirmRest;
var DeusExPlayer Rester;
var() string RestPointMessage;

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer P;

	Super.Frob(frobber, frobwith);

	P=DeusExPlayer(Frobber);
	
	if(Rester != None)
		return;
		
	if(P == ConfirmRest)
	{
		PlayerRest(P);
		return;
	}

	P.ClientMessage(RestPointMessage);
	ConfirmRest = P;
}

function PlayerRest(DeusExPlayer P)
{
	P.HealPlayer(200, false);
	P.ClientFlash(6, vect(1000,1000,1000));
	bBlockPlayers = true;
	Rester = P;
	SetTimer(4.5, false);
}

function Tick(float deltaTime)
{
	if(Rester!=None)
	{
		Rester.SetLocation(Location);
	}
}

function Timer()
{
	Rester.ClientMessage("You're rested...");
	Rester = none; //Free to go.
	bBlockPlayers = false;
}

defaultproperties
{
     RestPointMessage="It seems okay to rest here for a while. Press again to confirm."
     bInvincible=True
     ItemName="Rest Point"
     bPushable=False
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex6'
     Skin=Texture'DeusExDeco.Skins.AlarmLightTex6'
     DrawScale=1.500000
     CollisionRadius=45.200001
     CollisionHeight=32.000000
     bBlockPlayers=False
}
