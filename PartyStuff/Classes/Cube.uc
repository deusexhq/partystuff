//=============================================================================
// DarkMaiden.
//=============================================================================
class Cube extends CrateUnbreakableMed;

function BeginPlay()
{
	SetTimer(2,True);
}

function Bump(actor Other)
{
//Do nothing.
}

function Timer()
{
local DeusExDecoration deco;
local Pawn paw;

	foreach VisibleActors(class'DeusExDecoration', deco, 256)
		if (deco != None && deco != self)
			deco.TakeDamage(20, none, deco.Location, vect(0,0,0), 'Flamed');
	
	foreach VisibleActors(class'Pawn', paw, 256)
		if (paw != None)
			paw.TakeDamage(20, paw, paw.Location, vect(0,0,0), 'Flamed');
}

defaultproperties
{
     bInvincible=False
     ItemName="Cube of Pain"
     bPushable=False
     Physics=PHYS_Rotating
     Texture=FireTexture'Effects.Electricity.Nano_SFX_A'
     Skin=FireTexture'Effects.Electricity.Nano_SFX_A'
     DrawScale=1.500000
     CollisionRadius=25.000000
     CollisionHeight=76.000000
     bFixedRotationDir=True
     Mass=500.000000
     RotationRate=(Pitch=11192,Yaw=11192,Roll=11192)
}
