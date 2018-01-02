//=============================================================================
// VendingMachine.
//=============================================================================
class mpVendingMachine extends ElectronicDevices;

#exec OBJ LOAD FILE=Ambient

enum ESkinColor
{
	SC_Drink,
	SC_Snack
};

var() ESkinColor SkinColor;
var() class<Inventory> ItemSale;
var() int Price;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Drink:	Skin = Texture'VendingMachineTex1'; ItemSale = class'DeusEx.Sodacan'; break;
		case SC_Snack:	Skin = Texture'VendingMachineTex2'; break;
	}
	
	if(ItemSale == None)
		ItemSale = class'DeusEx.Candybar';  
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
		if (player.Credits >= Price)
		{
			PlaySound(sound'VendingCoin', SLOT_None);
			loc = Vector(Rotation) * CollisionRadius * 0.8;
			loc.Z -= CollisionHeight * 0.7; 
			loc += Location;

			product = Spawn(ItemSale, None,, loc);

			if (product != None)
			{
				if (product.IsA('Sodacan'))
					PlaySound(sound'VendingCan', SLOT_None);
				else
					PlaySound(sound'VendingSmokes', SLOT_None);
					
				if(product.isA('Estus'))
					Estus(product).bEstusArmed=False;
				if(product.isA('PoisonEstus'))
					PoisonEstus(product).bEstusArmed=False;
					
				product.Velocity = Vector(Rotation) * 100;
				product.bFixedRotationDir = True;
				product.Lifespan = 6;
				product.RotationRate.Pitch = (32768 - Rand(65536)) * 4.0;
				product.RotationRate.Yaw = (32768 - Rand(65536)) * 4.0;
			}

			player.Credits -= Price;
			player.ClientMessage("Bought "$Product.itemname$" for "$Price$" credits.");
		}
		else
			player.ClientMessage("Needs"@Price@"credits.");
	}
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Vending Machine"
     Mesh=LodMesh'DeusExDeco.VendingMachine'
     SoundRadius=8
     SoundVolume=96
     AmbientSound=Sound'Ambient.Ambient.HumLow3'
     CollisionRadius=34.000000
     CollisionHeight=50.000000
     Mass=150.000000
     Buoyancy=100.000000
}
