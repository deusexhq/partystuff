//=============================================================================
// Makes a drone, sleeps, and waits.
//=============================================================================
class DroneBox extends Containers;

//var DeusExPlayer tmpFrob;

function Destroyed()
{
}

function Frob(Actor Frobber, Inventory frobWith) 
{
	TakeDamage(50, DeusExPlayer(Frobber), Location, vect(0,0,0), 'fell');
	//tmpFrob = DeusExPlayer(Frobber);
}

simulated function Frag(class<fragment> FragType, vector Momentum, float DSize, int NumFrags) 
{
	local int i;
	local actor A, Toucher;
	local DeusExFragment s;
	local DroneBoxRespawner DBR;
	local RadarDrone RD;
	
	if ( bOnlyTriggerable )
		return; 
	if (Event!='')
		foreach AllActors( class 'Actor', A, Event )
			A.Trigger( Toucher, pawn(Toucher) );
	if ( Region.Zone.bDestructive )
	{
		Destroy();
		return;
	}
	for (i=0 ; i<NumFrags ; i++) 
	{
		s = DeusExFragment(Spawn(FragType, Owner));
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Momentum,0);
			s.DrawScale = DSize*0.5+0.7*DSize*FRand();
			s.Skin = GetMeshTexture();
			if (bExplosive)
				s.bSmoking = True;
		}
	}

	if (!bExplosive)
	{
		Spawn(class'RadarDrone',,,Location);
		//RD.Frob(tmpFrob,None);
				Destroy();
		DBR = Spawn(class'DroneBoxRespawner',,,Location);
		DBR.SetTimer(30,False);
	}
}

defaultproperties
{
     HitPoints=10
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Drone Storage Container"
     bPushable=False
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.CrateBreakableMed'
     CollisionRadius=34.000000
     CollisionHeight=24.000000
     Mass=50.000000
     Buoyancy=60.000000
}
