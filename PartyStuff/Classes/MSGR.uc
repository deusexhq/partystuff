//=============================================
// MSGR object
//=============================================
Class MSGR extends DeusExDecoration;

//make the glowing thing permenant, do something else for unread
var bool bNew, bReturning;
var(MSGR) string myMSG, MSGSender, MSGTimestamp;
var bool bSentByPlayer;

function Tick(float v)
{
	/*if(bNew && LightType != LT_Steady)
	{
		LightHue=0;
		LightRadius=18;
		LightSaturation=175;
		LightType=LT_Steady;
		LightEffect=LE_NonIncidence;
	}*/
		
	if(!bReturning)
	{
		Drawscale+=0.02;
		if(Drawscale >= 1.5)
		{
			bReturning=True;
		}
	}
	else
	{
		Drawscale-=0.02;
		if(Drawscale <= 1.0)
		{
			bReturning=False;
		}
	}

}

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer P;

	/*if(bNew)
	{
		bNew=False;
		LightType=LT_None;
	}*/
	
	P = DeusExPlayer(Frobber);
//	P.ClientMessage("|P3"$MSGSender$"|P3 @ "$MSGTimestamp);
	if(bSentByPlayer)
	{
		P.ClientMessage("|P3["$MSGSender$"|P3 @ "$MSGTimestamp$"]");
		P.ClientMessage("|P1"$myMsg);
	}
	else
	{
		if(MSGSender != "")
			P.ClientMessage("|P3["$MSGSender$"|P3]");
		P.ClientMessage("|P1"$myMsg);
	}
		
		if(P.bIsCrouching && P.bAdmin && bSentByPlayer)
		{
			P.ClientMessage("Message deleted.");
			Destroy();
		}
		
	Super.Frob(frobber, frobwith);
}

defaultproperties
{
     //bNew=True
     myMSG="DEFAULT MSG - REPORT AS BUG"
     MSGSender="NO SENDER DATA"
     MSGTimestamp="NO:TIME"
     bInvincible=True
     ItemName="Player Created Message"
     bPushable=False
     Physics=PHYS_None
     DrawType=DT_Sprite
     Style=STY_Translucent
     Sprite=Texture'DeusExUI.UserInterface.LogIcon'
     Texture=Texture'DeusExUI.UserInterface.LogIcon'
     Skin=Texture'DeusExUI.UserInterface.LogIcon'
     CollisionRadius=25.200001
     CollisionHeight=25.000000
     bBlockPlayers=False
}
