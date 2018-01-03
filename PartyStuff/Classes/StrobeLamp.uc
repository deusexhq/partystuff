//=============================================================================
// RandomColourLamp.
//=============================================================================
class StrobeLamp expands Lamp;

function tick(float v)
{
local int random;
	random = Rand(255);
	if(bOn)
	{
	LightHue = random;
		if(LightType != LT_Steady)
		{
			LightType=LT_Steady;
			LightEffect=LE_NonIncidence;		
		}
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
	}
	else
	{
		LightType=LT_None;
	}
}

defaultproperties
{
     bInvincible=True
     ItemName="Strobe Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp2'
     CollisionRadius=15.000000
     CollisionHeight=47.000000
     LightSaturation=0
     LightRadius=18
}
