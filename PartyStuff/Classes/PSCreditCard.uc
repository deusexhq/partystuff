//================================================
// PSCreditCard
//================================================
Class PSCreditCard extends DeusExWeapon;

var int mode;
var string Job;
var int Fitness, Strength, Intellect, CrimLevel;

var bool bDeposit;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) || (BeltSpot == 0) );
}
/*)
function DropFrom(vector StartLocation)
{
}
*/

function BecomePickup()
{
   Super(Inventory).BecomePickup();
   lifespan=0;
   SetDisplayProperties(Default.Style, Default.Texture, Default.bUnlit, Default.bMeshEnviromap );
}

function Fire(float Value) 
{
	local DeusExPlayer P;
	local vector loc;
	local rotator rot;
	
	P=DeusExPlayer(Owner);

	loc = Owner.Location;
	rot = Owner.Rotation;
	loc += 2.0 * Owner.CollisionRadius * vector(P.ViewRotation);
	loc.Z += Owner.CollisionHeight * 0.9;

	if(mode==10)
	{
		if(P.Credits>=10)
		{
			P.Credits-=10;
		
			Spawn(class'Cred10', Owner,, loc, rot);
			return;
		}
	}

	if(mode==100)
	{
		if(P.Credits>=100)
		{
			P.Credits-=100;
			Spawn(class'Cred100', Owner,, loc, rot);
			return;
		}
	}

	if(mode==500)
	{
		if(P.Credits>=500)
		{
			P.Credits-=500;
			Spawn(class'Cred500', Owner,, loc, rot);
			return;
		}
	}
}

simulated function ScopeToggle() 
{ 
	if(mode == 500)
	{
		mode = 10;
		DeusExPlayer(Owner).ClientMessage("10 Credit mode selected.");
		return;
	}

	if(mode == 100)
	{
		mode = 500;
		DeusExPlayer(Owner).ClientMessage("500 Credit mode selected.");
		return;
	}

	if(mode == 10)
	{
		mode = 100;
		DeusExPlayer(Owner).ClientMessage("100 Credit mode selected.");
		return;
	}
}

function CycleAmmo()
{
	if(bDeposit == False)
	{
		bDeposit = True;
		DeusExPlayer(Owner).ClientMessage("|p7ATM deposit mode selected.");
	}
	else
	{
		bDeposit = False;
		DeusExPlayer(Owner).ClientMessage("|p7ATM withdrawl mode selected.");
	}
}

function Tick(float deltatime)
{
	if(Owner!=None)
	{
		if(Owner.IsA('Human'))
		{
			if(Human(Owner).Health > 0)
			{
				AmmoType.AmmoAmount = DeusExPlayer(Owner).Credits;
	
				if(AmmoType.AmmoAmount > 10)
				{
					//AmmoType.beltDescription = "|p7C"$DeusExPlayer(Owner).Credits;
					DeusExRootWindow(DeusExPlayer(Owner).rootWindow).hud.belt.Objects[0].ItemText = "|p3C "$DeusExPlayer(Owner).Credits;
				}
				else
				{
					//AmmoType.beltDescription = "|p2C"$DeusEXPlayer(Owner).Credits;
					DeusExRootWindow(DeusExPlayer(Owner).rootWindow).hud.belt.Objects[0].ItemText = "|p2C "$DeusExPlayer(Owner).Credits;
				}
			}
		}
	}
}

defaultproperties
{
     Mode=10
     AmmoName=Class'PartyStuff.AmmoCredits'
     ReloadCount=1
     PickupAmmoCount=120
     InventoryGroup=80
     ItemName="Citizen card"
     PlayerViewOffset=(Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Credits'
     PickupViewMesh=LodMesh'DeusExItems.Credits'
     ThirdPersonMesh=LodMesh'DeusExItems.Credits'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconCredits'
     beltDescription="CITIZEN"
     Mesh=LodMesh'DeusExItems.Credits'
     CollisionRadius=7.000000
     CollisionHeight=0.550000
     Mass=2.000000
     Buoyancy=3.000000
}
