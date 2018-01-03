//=============================================================================
// Switch1.
//=============================================================================
class ShopButton2 extends DeusExDecoration;

var(RPG) int Price;
var(RPG) class<Decoration> ShopItem;
var(RPG) string purchasealias;
var(RPG) name CTag;

var bool bConfirm;

function Timer()
{
bConfirm=False;
}

function Frob(Actor Frobber, Inventory frobWith)
{
      local DeusExPlayer Player;
	  local ShopConstructor SC;
	  
      Player = DeusExPlayer(Frobber);

		if(bConfirm)
		{
			if(Player.Credits >= Price)
			{
				foreach AllActors(class'ShopConstructor', SC)
				{
					if(SC.Tag == CTag)
					{
						Spawn(ShopItem,,,SC.Location);
					}
				}
			Player.Credits -= Price;
			Player.ClientMessage("|P3Purchased |P2"$purchasealias$" |P3for |P2"$Price$"|P3. |P1(New credits: "$Player.Credits$")");
						bConfirm=False;
			}
			else
			{
			Player.ClientMessage("|P3You can't afford this purchase.");
			bConfirm=False;
			}
		}
		else
		{
		Player.ClientMessage("|P3Purchase trigger |p2"$purchasealias$" |P3for |P2"$Price$"|P3? Press again to confirm. |P1(Current credits: "$Player.Credits$")");
		bConfirm=True;
		SetTimer(3,False);
		}
}

defaultproperties
{
     bInvincible=True
     ItemName="Furniture Shop"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Switch1'
     CollisionRadius=2.630000
     CollisionHeight=2.970000
     Mass=10.000000
     Buoyancy=12.000000
}
