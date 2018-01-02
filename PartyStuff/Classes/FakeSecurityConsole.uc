//=============================================================================
// FakeSecurityConsole.
//=============================================================================
class FakeSecurityConsole extends DeusExDecoration;

var bool bOn;

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if (bOn)
	{
		PlayAnim('Deactivate');
	}
	else
	{
		PlayAnim('Activate');
	}

	bOn = !bOn;
}

defaultproperties
{
     bInvincible=True
     ItemName="Security Computer Terminal"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.ComputerSecurity'
     CollisionRadius=11.590000
     CollisionHeight=10.100000
     bCollideWorld=False
     Mass=10.000000
     Buoyancy=12.000000
}
