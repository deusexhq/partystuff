//=============================================
// MSGR object
//=============================================
Class HiddenFrob extends DeusExDecoration;

var() bool bMessage, bTrigger, bTimedrepeat;
var() int TimedRepeat;
var() string mMessage;

function Timer()
{
}

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer P;
	P = DeusExPlayer(Frobber);
	if(bMessage)
	{
		P.ClientMessage(mMessage);
	}
	if(bTrigger)
	{
	Super.Frob(frobber, frobwith);
		if(bTimedrepeat)
			SetTimer(TimedRepeat,False);
	}
}

defaultproperties
{
     bInvincible=True
     ItemName="???"
     bPushable=False
	 bMovable=False
     Physics=PHYS_None
     DrawType=DT_Mesh
     Style=STY_Translucent
     Sprite=Texture'DeusExUI.UserInterface.LogIcon'
     Texture=Texture'DeusExUI.UserInterface.LogIcon'
     Skin=Texture'DeusExUI.UserInterface.LogIcon'
     CollisionRadius=25.200001
     CollisionHeight=25.000000
     bBlockPlayers=False
}
