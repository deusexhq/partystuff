//=============================================================================
// Switch1.
//=============================================================================
class ShopButton extends DeusExDecoration;

var(RPG) int Price;
var(RPG) class<inventory> ShopItem;
var(RPG) bool bTriggerInstead; 
var(RPG) string purchasealias;
var DeusExPlayer LastBuyer;
var bool bConfirm;

function SilentAdd(class<inventory> addClass, DeusExPlayer addTarget)
{ 
	local Inventory anItem;
	
	anItem = Spawn(addClass,,,addTarget.Location); 
	anItem.SpawnCopy(addTarget);
	anItem.Destroy();
	/*anItem.Instigator = addTarget; 
	anItem.GotoState('Idle2'); 
	anItem.bHeldItem = true; 
	anItem.bTossedOut = false; 
	
	if(Weapon(anItem) != None) 
		Weapon(anItem).GiveAmmo(addTarget); 
	anItem.GiveTo(addTarget);*/
}

function Timer()
{
bConfirm=False;
}

function Frob(Actor Frobber, Inventory frobWith)
{
      local Inventory Inv;
      local DeusExPlayer Player;
      local bool bPositionFound;
      local int beltpos;
      
      Player = DeusExPlayer(Frobber);

	if(bTriggerInstead)
	{
		if(bConfirm)
		{
			if(Player.Credits >= Price)
			{
			super.Frob(frobber,frobWith);
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
	else
	{
		if(bConfirm)
		{
			if(Player.Credits >= Price)
			{	 
				 
			/*	if(!player.FindInventorySlot(inventory(shopitem.class), True))
				
				if(!bPositionFound)
				{
					Player.ClientMessage("Not enough room for this item...");
					return;
				}*/
			/*inv.InitialState='Idle2';
			inv.GiveTo(Player);
			inv.SetBase(Player);*/
			SilentAdd(shopItem, Player);
			LastBuyer = Player;
			Player.Credits -= Price;
			Player.ClientMessage("|P3Purchased|P2 "$purchasealias$"|P3 for |P2"$Price$"|P3. |P1(New credits: "$Player.Credits$")");
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
		Player.ClientMessage("|P3Purchase |P2"$purchasealias$" |P3for |P2"$Price$"|P3? Press again to confirm. |P1(Current credits: "$Player.Credits$")");
		bConfirm=True;
		SetTimer(3,False);
		}

	}

}

defaultproperties
{
     bInvincible=True
     ItemName="Shop"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Switch1'
     CollisionRadius=2.630000
     CollisionHeight=2.970000
     Mass=10.000000
     Buoyancy=12.000000
}
