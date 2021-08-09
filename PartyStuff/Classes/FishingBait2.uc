//=============================================================================
// BoxLarge.
//=============================================================================
class FishingBait2 extends Containers;

var FishingDevice MainDev;
var bool bHasCatch;
var int FishTime;

function Timer()
{
	if(!bHasCatch)
	{
		bHasCatch=True;
		DeusExPlayer(MainDev.Owner).ClientMessage("Somethings biting!!");
		SetTimer(Rand(5), False);
	}
	else
	{
		bHasCatch=False;
		DeusExPlayer(MainDev.Owner).ClientMessage("It got away...");
	}
}

function PingCatch()
{
	MainDev.Catches++;
	MainDev.Stage = 0;
	DeusExPlayer(MainDev.Owner).ClientMessage("Got it! "$MainDev.Catches$" fish caught.");
	MainDev.Lure = None;
	Destroy();
}

defaultproperties
{
     bFloating=True
     ItemName="Fishing Bait"
     bBlockSight=True
     Skin=FireTexture'Effects.liquid.Virus_SFX'
     Mesh=LodMesh'DeusExDeco.Basketball'
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     Mass=100.000000
     Buoyancy=200.000000
}
