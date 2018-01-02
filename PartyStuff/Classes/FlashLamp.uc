//=============================================================================
// RandomColourLamp.
//=============================================================================
class FlashLamp expands Lamp;

var() float switchTime;

function PostBeginPlay()
{
	if (bOn)
	{
		LightType=LT_Steady;
		LightEffect=LE_NonIncidence;
		SetTimer(switchTime,false);
	}
}

function timer()
{
local int random;
	if(bOn)
	{
	random = Rand(255);
	LightHue = random;
	SetTimer(switchTime,false);
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
    local int Random;
	Super.Frob(Frobber, frobWith);

	if (bOn)
	{
		LightType=LT_Steady;
		LightEffect=LE_NonIncidence;
		SetTimer(switchTime,false);
	}
	else
	{
		LightType=LT_None;
	}
}

defaultproperties
{
     SwitchTime=1.000000
     bInvincible=True
     ItemName="Flash Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp2'
     CollisionRadius=15.000000
     CollisionHeight=47.000000
     LightSaturation=0
     LightRadius=18
}
