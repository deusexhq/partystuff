Class PSTurretController extends DeusExDecoration;

var Pawn myOwner;
var() string PTurretTeam;

function Frob(Actor Frobber, Inventory frobWith) 
{
	DeusExPlayer(Frobber).ClientMessage(myOwner.PlayerReplicationInfo.PlayerName@PTurretTeam);
	if(Pawn(Frobber) == myOwner)
	{
		myOwner = None;
			DeusExPlayer(Frobber).ClientMessage("Removed from Turret Safe List for group"@PTurretTeam);
			return;
	}
	
	if(myOwner == None)
	{
		myOwner = Pawn(Frobber);
		DeusExPlayer(Frobber).ClientMessage("Added to Turret Safe List for group"@PTurretTeam);
	}
}

defaultproperties
{
     PTurretTeam="DEFAULT"
     bCanBeBase=True
     ItemName="Turret Dominator"
     bPushable=False
     Texture=Texture'DeusExItems.Skins.DataCubeTex2'
     Mesh=LodMesh'DeusExItems.DataCube'
     CollisionRadius=7.000000
     CollisionHeight=1.270000
     Mass=10.000000
}
