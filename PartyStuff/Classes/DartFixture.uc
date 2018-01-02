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
     Mesh=LodMesh'DeusExItems.Biocell'
     CollisionRadius=28.000000
	 Drawscale=6
     CollisionHeight=0.500000
     ItemName="Dart Fixture"
     bUnlit=True
	 bPushable=False
	 bCanBeBase=True
	 bMovable=False
	 bInvincible=true
     LightEffect=LE_Disco
     LightBrightness=255
     LightSaturation=50
     LightRadius=4
}
