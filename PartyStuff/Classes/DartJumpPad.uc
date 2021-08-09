//=============================================================================
// DartFlare.
//=============================================================================
class DartJumpPad extends DeusExDecoration;

var int Velz;

/*
function Bump(actor Other)
{
	if(deusExPlayer(Other) != None)
	{
	DeusExPlayer(Other).DoJump();
	DeusExPlayer(Other).Velocity = (normal(Location - Other.Location) * Velz);
	DeusExPlayer(Other).SetPhysics(Phys_Falling);	
	}
}*/

singular function SupportActor(Actor other)
{
	if(deusExPlayer(Other) != None)
	{
	DeusExPlayer(Other).DoJump();
	DeusExPlayer(Other).Velocity = (normal(Location - Other.Location) * Velz);
	DeusExPlayer(Other).SetPhysics(Phys_Falling);	
	}
	if(DeusExDecoration(Other) != None)
	{
	DeusExDecoration(Other).SetPhysics(Phys_Falling);	
	DeusExDecoration(Other).Velocity = (normal(Location - Other.Location) * Velz);
	}
	if(ScriptedPawn(Other) != None)
	{
	ScriptedPawn(Other).SetPhysics(Phys_Falling);	
	ScriptedPawn(Other).Velocity = (normal(Location - Other.Location) * Velz);
	}
}

function BeginPlay()
{
    local int Random, count;
	local DartJumpPad DJP;
	foreach AllActors(class'DartJumpPad',DJP)
		count++;
		
	if(count < 21)
	{
	Random = rand(256);
	LightHue=Random;
	LightType=LT_Steady;
	}
	else
		Destroy();
}

defaultproperties
{
     bInvincible=True
     bCanBeBase=True
     ItemName="Jump Pad"
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
