class PGSItem extends DeusExDecoration;

var bool bActive;

function Frob(Actor Frobber, Inventory frobWith)
{
local PGSItem PGSI;
local int myCount;
	if(bActive)
	{
	bActive=False;
	DeusExPlayer(Frobber).PlayerReplicationInfo.Score += 3;
	BroadcastMessage(DeusExPlayer(Frobber).PlayerReplicationInfo.PlayerName$" has found an item.");
	myCount = 0;
		foreach AllActors(class'PGSItem',PGSI)
		{
			myCount++;
		}
		myCount -= 1; //Count out THIS one
	BroadcastMessage(myCount$" remaining.");
	destroy();
	return;	
	}
}

defaultproperties
{
     bInvincible=True
     bCanBeBase=True
     ItemName="Scavenger Item"
     bPushable=False
     bBlockSight=True
     Mesh=LodMesh'DeusExItems.VialAmbrosia'
     MultiSkins(1)=FireTexture'Effects.liquid.Virus_SFX'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=200.000000
     Buoyancy=40.000000
}
