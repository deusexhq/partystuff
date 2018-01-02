//=============================================================================
// Switch1.
//=============================================================================
class OwnedScanner2 extends DeusExDecoration
config (Owning);

var(Owning) bool bPaytoOwn;
var(Owning) int Price;
var(Owning) string OwnedAlias;
var(Owning) int ReadNumber;
var OwningController MyController;
 
var bool bConfirm;
var int Bid;
var bool bPayout;

function string GetName(deusexplayer P)
{
	return P.PlayerReplicationInfo.PlayerName;
}

function Frob(Actor Frobber, Inventory frobWith)
{
local DeusExPlayer p;
p = DeusExPlayer(Frobber);

	if(MyController.Owners[readNumber] != "")
	{
		if(getName(p) ~= MyController.Owners[readnumber])
		{
			p.ClientMessage("|P3Passed owner check! Welcome back, Owner #"$ReadNumber$" - "$MyController.Owners[readnumber]);
			super.Frob(frobber, frobWith);
			return;
		}
		else
		{
			p.ClientMessage("|P2Failed owner check! Owned by #"$ReadNumber$" - "$MyController.Owners[readnumber]);
			return;
		}
	}

		if(bPaytoOwn)
		{
			if(!bConfirm)
			{
				p.ClientMessage(Price$" to own "$ownedalias$", press again to confirm? |P1(Current credits: "$P.Credits$")");
				bConfirm = True;
				SetTimer(3,False);
			}
			else
			{
				if(p.Credits >= Price)
				{
					myController.Owners[readNumber] = GetName(P);
					myController.SaveConfig();
					p.Credits -= Price;
					p.ClientMessage(GetName(P)$", you now own the object"@ownedalias$" |P1(New credits: "$P.Credits$")");
					bConfirm = False;
				}
				else
				{p.ClientMessage("You can't afford this purchase.");}
			}

		}
		else
		{
			myController.Owners[readNumber] = GetName(P);
			myController.SaveConfig();
			p.ClientMessage(P.PlayerReplicationInfo.PlayerName$", you now own the object"@ownedalias);
		}

}

defaultproperties
{
     bInvincible=True
     ItemName="Ownable Scanner"
     bPushable=False
     Physics=PHYS_None
     Texture=Texture'DeusExItems.Skins.DataCubeTex2'
     Mesh=LodMesh'DeusExItems.DataCube'
     CollisionRadius=7.000000
     CollisionHeight=1.270000
     Buoyancy=12.000000
}
