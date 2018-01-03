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

     bInvincible=True
     HitPoints=100
     ItemName="Race Marker"
     //bMovable=False
     bPushable=False
     bHighlight=False
     LightBrightness=100
     Physics=PHYS_Rotating
     Lighttype=LT_Steady
     LightRadius=10
     Ambientglow=255
     LightSaturation=255
	 Drawscale=1
	 Fatness=140
	 style=sty_translucent
	 bBlockPlayers=False
     Mesh=LodMesh'DeusExDeco.Lightbulb'
     Texture=Texture'DeusExUI.UserInterface.AugIconCombat_Small';
     CollisionRadius=5.000000
     CollisionHeight=8.000000
          bFixedRotationDir=True
     RotationRate=(Yaw=8192)
}
