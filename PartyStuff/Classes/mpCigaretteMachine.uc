//=============================================================================
// CigaretteMachine.
//=============================================================================
class mpCigaretteMachine extends ElectronicDevices;
//Add check for if dispensing Estus SPECIAL CASE
//Make it Armed False
#exec OBJ LOAD FILE=Ambient

var() class<Inventory> ItemSale;
var() int Price;

function BeginPlay()
{
	Super.BeginPlay();
	
	if(ItemSale == None)
		ItemSale = class'DeusEx.Cigarettes';  
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
		if (player.Credits >= price)
		{
			PlaySound(sound'VendingCoin', SLOT_None);
			loc = Vector(Rotation) * CollisionRadius * 0.8;
			loc.Z -= CollisionHeight * 0.6; 
			loc += Location;

			product = Spawn(ItemSale, None,, loc);

			if (product != None)
			{
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

			player.Credits -= price;
			player.ClientMessage("Bought "$Product.itemname$" for "$Price$" credits.");
		}
		else
			player.ClientMessage("Needs"@Price@"credits.");
	}
}

defaultproperties
{
     ItemName="Cigarette Machine"
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.CigaretteMachine'
     SoundRadius=8
     SoundVolume=96
     AmbientSound=Sound'Ambient.Ambient.HumLight3'
     CollisionRadius=27.000000
     CollisionHeight=26.320000
     Mass=150.000000
     Buoyancy=100.000000
}
