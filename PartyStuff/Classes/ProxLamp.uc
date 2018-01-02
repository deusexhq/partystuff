//=============================================================================
// RandomColourLamp.
//=============================================================================
class ProxLamp expands Lamp;

var int Mode;
var DeusExPlayer tempPwn;
var bool bFoundPlayer;

function Tick(float deltaTime)
{
	local DeusExPlayer player;

		bFoundPlayer=False;
		foreach VisibleActors(class'DeusExPlayer', player, 256)
		{
			bFoundPlayer=True;
		}
		
		if(bFoundPlayer && LightType==LT_None)
		{
					bOn = True;
					LightType = LT_Steady;
					PlaySound(sound'Switch4ClickOn');
					bUnlit = True;
					ScaleGlow = 2.0;					
		}
		else if(!bFoundPlayer && LightType==LT_Steady)
		{
				bOn = False;
				LightType = LT_None;
				PlaySound(sound'Switch4ClickOff');
				bUnlit = False;
				ResetScaleGlow();
		}
	Super.Tick(deltaTime);
}

defaultproperties
{
     bInvincible=True
     ItemName="Proximity Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp2'
     CollisionRadius=15.000000
     CollisionHeight=47.000000
     LightSaturation=0
     LightRadius=18
}
