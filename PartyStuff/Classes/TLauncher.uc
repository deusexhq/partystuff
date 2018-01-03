//=============================================
// RestPoint
//=============================================
Class TLauncher extends DeusExDecoration;

enum TMode
{
	T_Normal, //Launches as original
	T_Companion, //It spawns with you
	T_Pickup, //frob to pickup
};
var config TMode TM;
var bool bCooldown;
var() float Cooldown;
var float LastLaunchTime;

replication
{
	// MBCODE: Replicate the last time healed to the server
	reliable if ( Role < ROLE_Authority )
		LastLaunchTime, Cooldown;
}
function Timer()
{
	bCooldown=False;
	Texture=Texture'DeusExDeco.Skins.AlarmLightTex4';
	LightHue=70;
}

function SilentAdd(class<inventory> addClass, DeusExPlayer addTarget)
{ 
	local Inventory anItem;
	
	anItem = Spawn(addClass); 
	anItem.Instigator = addTarget; 
	anItem.GotoState('Idle2'); 
	anItem.bHeldItem = true; 
	anItem.bTossedOut = false; 
	
	if(Weapon(anItem) != None) 
		Weapon(anItem).GiveAmmo(addTarget); 
	anItem.GiveTo(addTarget);
}

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer P;
	local TRocket TR;
	local TLItem h;
	local rotator Z2F;
	P=DeusExPlayer(Frobber);
	
		if(DeusExPlayer(Frobber).bIsCrouching && P.bAdmin)
		{
			if(TM==T_Normal)
			{
				TM=T_Companion;
				P.ClientMessage("Companion Mode; Launcher will follow you when you warp.");
				return;
			}
			else if(TM==T_Companion)
			{
				TM=T_Pickup;
				P.ClientMessage("Pickup Mode; Launcher will be collected.");
				return;
			}
			else if(TM==T_Pickup)
			{
				TM=T_Normal;
				P.ClientMessage("Normal Mode; Static placement.");
				return;
			}
		}
		
		if(TM==T_Pickup)
		{
			Destroy();
			SilentAdd(class'TLItem', P);
			return;
		}
		else
		{
			if(Cooled())
			{
				Z2F=P.Rotation;
				TR = Spawn(class'TRocket',,,Location + (CollisionRadius + TR.Default.CollisionRadius + 30) * vector(Rotation) * BaseEyeHeight,Z2F);
				TR.SetOwner(P);
				P.UnderWaterTime = -1.0;	
				P.bHidden=True;
				P.SetCollision(false, false, false);
				P.bCollideWorld = true;
				P.GotoState('PlayerWalking');
				LastLaunchTime = Level.TimeSeconds;
					if(TM==T_Normal)
					{
						bCooldown=True;
						Texture=Texture'DeusExDeco.Skins.AlarmLightTex2';
						LightHue=0;
						SetTimer(Cooldown,false);
					}
					if(TM==T_Companion)
					{
					TR.bCompanion=True;
					Destroy();
					}
			}
			else
			{
				P.ClientMessage("Launcher is cooling down, please wait "$int(Cooldown - (Level.TimeSeconds - lastLaunchTime))$" seconds.");
			}
		}

}

function bool Cooled()
{	
	return (Level.TimeSeconds - lastLaunchTime > Cooldown);
}

defaultproperties
{
     Cooldown=10.000000
     bInvincible=True
     ItemName="Travel Bomber"
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
