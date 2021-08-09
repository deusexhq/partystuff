//=============================================================================
// DartFlare.
//=============================================================================
class DartFixture extends DeusExDecoration;

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);
	Destroy();
}

function BeginPlay()
{
    local int Random;
	Random = rand(256);
	LightHue=Random;
	LightType=LT_Steady;
}

defaultproperties
{
     bInvincible=True
     bCanBeBase=True
     ItemName="Dart Fixture"
     bPushable=False
     bMovable=False
     Mesh=LodMesh'DeusExItems.BioCell'
     DrawScale=6.000000
     bUnlit=True
     CollisionRadius=28.000000
     CollisionHeight=0.500000
     LightEffect=LE_Disco
     LightBrightness=255
     LightSaturation=50
     LightRadius=4
}
