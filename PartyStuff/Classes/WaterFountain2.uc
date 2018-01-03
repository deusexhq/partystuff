//=============================================================================
// WaterFountain.
//=============================================================================
class WaterFountain2 extends DeusExDecoration;

var bool bUsing;

function Timer()
{
	bUsing = False;
	PlayAnim('Still');
	AmbientSound = None;
}

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if (bUsing)
		return;

	SetTimer(2.0, False);
	bUsing = True;

	// heal the frobber a small bit
	if (DeusExPlayer(Frobber) != None)
		DeusExPlayer(Frobber).HealPlayer(50);

	LoopAnim('Use');
	AmbientSound = sound'WaterBubbling';
}

defaultproperties
{
     ItemName="Water Fountain"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.WaterFountain'
     CollisionRadius=20.000000
     CollisionHeight=24.360001
     Mass=70.000000
     Buoyancy=100.000000
}
