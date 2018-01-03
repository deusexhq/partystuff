//=============================================================================
// SmokeCloud - by Deadalus08.
//=============================================================================
class SmokeCloud extends Cloud;


simulated function Tick(float deltaTime)
{
	//override this function to avoid having the drawscale changed
}

defaultproperties
{
     DamageType=TearGas
     Damage=0.500000
     bBlockSight=True
     bDetectable=False
     Texture=FireTexture'Effects.Smoke.SmokePuff1'
}
