//=============================================================================
// CrateUnbreakableLarge.
//=============================================================================
class DoorCrate extends Containers;

var bool bRevealing, bFading, bBlockFrob;

function Frob(Actor Frobber, Inventory frobWith)
{
	if(bfading || brevealing || bBlockfrob)
		return;
	if(Scaleglow < 0.1)
	{
		bRevealing=True;
	}
	else
	{
		Style=STY_Translucent;
		bFading=True;
	}
}

function Trigger( actor Other, pawn EventInstigator )
{
	if(bfading || brevealing)
		return;
	if(Scaleglow < 0.1)
	{
		bRevealing=True;
	}
	else
	{
		Style=STY_Translucent;
		bFading=True;
	}
}

function Tick(float deltatime)
{
	if(bRevealing)
	{
		Scaleglow+=0.05;
		if(Scaleglow>0.99)
		{
			bRevealing=False;
			Style=STY_Normal;
			SetCollision(True, True, True);
			bCollideWorld = true;
		}
	}
	if(bFading)
	{
		Scaleglow-=0.05;
		if(Scaleglow<0.01)
		{
			bFading=False;
			SetCollision(False, False, False);
			bCollideWorld = true;
		}
	}	
}

defaultproperties
{
     bBlockFrob=True
     bInvincible=True
     bFlammable=False
     ItemName="Metal Door Crate"
     bPushable=False
     bMovable=False
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.CrateUnbreakableLarge'
     CollisionRadius=56.500000
     CollisionHeight=56.000000
     Mass=150.000000
     Buoyancy=160.000000
}
