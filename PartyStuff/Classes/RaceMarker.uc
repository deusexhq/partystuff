//=============================================
// Speedrun Race Marker etc..
//=============================================
Class RaceMarker extends DeusExDecoration;

var int Secs, Mins;
var bool bDisabled;

var RaceMarker EndPoint, StartPoint;

function PostBeginPlay()
{
	local RaceMarker RM;
	
	foreach AllActors(class'RaceMarker', RM)
	{
		
	}
}

function Tick(float deltatime)
{
	super.Tick(deltatime);

	RadialCollect();
}

function RadialCollect()
{
	local PlayerPawn P, winP;
	local vector dist;
	local float lowestDist;

	lowestDist = 1024;

	foreach VisibleActors(class'PlayerPawn', P, 50)
	{
		if(P != None && !P.IsInState('Dying') && P.Health > 0)
		{
			if(vSize(P.Location - Location) < lowestDist)
			{
				winP = P;
				lowestDist = vSize(P.Location - Location);
			}
		}
	}

	if(winP != None)
	{
		winP.ClientMessage("weehee");
	}
}

function Timer()
{

}

defaultproperties
{
     HitPoints=100
     bInvincible=True
     bHighlight=False
     ItemName="Race Marker"
     bPushable=False
     Physics=PHYS_Rotating
     Style=STY_Translucent
     Texture=Texture'DeusExUI.UserInterface.AugIconCombat_Small'
     Mesh=LodMesh'DeusExDeco.Lightbulb'
     AmbientGlow=255
     Fatness=140
     CollisionRadius=5.000000
     CollisionHeight=8.000000
     bBlockPlayers=False
     LightType=LT_Steady
     LightBrightness=100
     LightSaturation=255
     LightRadius=10
     bFixedRotationDir=True
     RotationRate=(Yaw=8192)
}
