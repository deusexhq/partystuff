//=============================================================================
// LightBall
//=============================================================================
class LightBall expands GraySpit;

var float TotalTime;

var() float TimeLimit;			//until when should I spawn?

function Tick(float deltaTime)
{
	local PlayerPawn Player;

	TotalTime+=deltaTime;

	if (TotalTime > TimeLimit)
	{
		Self.Destroy();
	}	
}

defaultproperties
{
     TimeLimit=0.500000
     Damage=0.000000
     SpawnSound=None
     DrawType=DT_Sprite
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex4'
     Mesh=None
}
