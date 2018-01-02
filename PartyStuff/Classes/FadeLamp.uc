//=============================================================================
// RandomColourLamp.
//=============================================================================
class FadeLamp expands Lamp;

function PostBeginPlay()
{
	if (bOn)
	{
		LightType=LT_Steady;
		LightEffect=LE_NonIncidence;
	}
}

function tick(float v)
{
	LightHue++;
	if(LightHue >= 255)
	{
		LightHue=0;
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
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
     ItemName="Fading Lamp"
     Mesh=LodMesh'DeusExDeco.Lamp2'
     CollisionRadius=15.000000
     CollisionHeight=47.000000
     LightSaturation=0
     LightRadius=18
}
