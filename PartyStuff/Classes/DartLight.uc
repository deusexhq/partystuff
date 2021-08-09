//=============================================================================
// DartFlare.
//=============================================================================
class DartLight extends Dart;

var float mpDamage;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
		Damage = mpDamage;
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
     mpDamage=10.000000
     spawnAmmoClass=Class'DeusEx.AmmoDartFlare'
     ItemName="Light Dart"
     Damage=5.000000
     LifeSpan=120.000000
     bUnlit=True
     LightEffect=LE_Disco
     LightBrightness=255
     LightSaturation=50
     LightRadius=20
}
