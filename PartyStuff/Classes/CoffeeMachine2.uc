//=============================================================================
// CoffeeMachine.
//=============================================================================
class CoffeeMachine2 extends ElectronicDevices;

#exec OBJ LOAD FILE=Ambient

var() class<Inventory> ItemSale;
var() int Price;

function BeginPlay()
{
	Super.BeginPlay();
	
	if(ItemSale == None)
		ItemSale = class'CoffeeCup2';  
}


function Frob(actor Frobber, Inventory frobWith)
{
	local DeusExPlayer player;
	local Vector loc;
	local Inventory product;

	Super.Frob(Frobber, frobWith);
	
	player = DeusExPlayer(Frobber);

	if (player != None)
	{
		if(Player.Credits >= Price )
		{
			PlaySound(sound'VendingCoin', SLOT_None);
			loc = Vector(Rotation) * CollisionRadius * 0.6;
			loc.Z -= CollisionHeight * 0.3; 
			loc += Location;

			product = Spawn(ItemSale, None,, loc);

			if (product != None)
			{
				PlaySound(sound'VendingCan', SLOT_None);
				product.Velocity = Vector(Rotation);
				product.Lifespan = 6;
				product.SetPhysics(PHYS_None);
				Player.Credits -= Price;
			}
			player.ClientMessage("Bought "$Product.itemname$" for "$Price$" credits.");
		}
		else
			player.ClientMessage("Needs"@Price@"credits.");
	}
}

defaultproperties
{
    Price=50
    bCanBeBase=True
    ItemName="Coffee Machine"
    Mesh=LodMesh'CoffeeMachine'
    SoundRadius=8
    SoundVolume=96
    AmbientSound=Sound'Ambient.Ambient.HumLow3'
    CollisionRadius=32.35
    CollisionHeight=50.00
    Mass=150.00
    Buoyancy=100.00
}
