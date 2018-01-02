//=============================================================
//=============================================================
Class CreditDeco extends DeusExDecoration;

Var() int CreditValue;
var() int RespawnTime;
Var() bool bShouldRespawn;
Var bool bRespawning;

function Timer()
{
	Drawscale = 1.000000;
	bHighlight = True;
	SetCollisionSize(Default.CollisionRadius, Default.CollisionHeight);
}

function BeginPlay()
{
	ItemName="c"$CreditValue;

//	if(creditvalue == 10)
//	{
	//	lifespan = 10.000000;
	//}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if(bShouldRespawn == True)
	{
		DeusExPlayer(Frobber).Credits += CreditValue;
		DeusExPlayer(Frobber).ClientMessage("You just picked up c"$CreditValue);
		DeusExPlayer(Frobber).FrobTarget = None; //Cozmo: NOW try duplicating money!
		Drawscale = 0.000000;
		bHighlight = False;
		SetTimer(RespawnTime, false);
		SetCollisionSize(0.000000, Default.CollisionHeight);
	}
	else
	{
		DeusExPlayer(Frobber).Credits += CreditValue;
		DeusExPlayer(Frobber).FrobTarget = None;
		DeusExPlayer(Frobber).ClientMessage("You just picked up c"$CreditValue);
		Destroy();
	}
}

defaultproperties
{
     CreditValue=50
     RespawnTime=480
     bInvincible=True
     bCanBeBase=True
     ItemName="Credit Chit"
     bPushable=False
     Mesh=LodMesh'DeusExItems.Credits'
     CollisionRadius=7.000000
     CollisionHeight=0.550000
     bBlockPlayers=False
     Mass=2.000000
     Buoyancy=3.000000
}
