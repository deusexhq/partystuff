//=============================================================================
// WeaponAssaultGun.
//=============================================================================
class coopWeaponPistolLight extends WeaponPistol;

var bool bTorchOn;
var Beam s;
var float TimeChange;
var() float TorchRadius, TorchBrightness;

function LaserToggle()
{
	TorchToggle();
}

function LaserOff()
{
	if(bTorchOn)
		TorchToggle();
}

function TorchToggle()
{
	if (bTorchOn)
	{
		bTorchOn=False;
		OffTorch();
	}
	else
	{
		bTorchOn=True;
		OnTorch();
	}
}

function OnTorch()
{
	local Vector HitNormal,HitLocation,EndTrace,StartTrace,X,Y,Z,NewHitLocation;
	
	DeusExPlayer(Owner).PlaySound(sound'Switch1Click', SLOT_Talk,2,,1024,);
	if(s == None)
	{
		s = Spawn(class'Beam',Owner,, HitLocation+HitNormal*40);
		s.LightRadius = TorchRadius;
		s.LightBrightness = TorchBrightness;
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);	
		EndTrace = Pawn(Owner).Location + 10000* Vector(Pawn(Owner).ViewRotation);
		Trace(HitLocation,HitNormal,EndTrace,Pawn(Owner).Location, True);
		s.SetLocation(HitLocation-vector(Pawn(Owner).ViewRotation)*64);
	}
}

function OffTorch()
{
DeusExPlayer(Owner).PlaySound(sound'Switch1Click', SLOT_Talk,2,,1024,);
	s.Destroy();
}

function GiveTo( pawn Other )
{
    super.Giveto(Other);
	Other.ClientMessage("Special Weapon: Can't be used on Players.");
	Other.ClientMessage("Special Weapon: Weapon has a Torch function.");
}

function Tick(Float Deltatime)
{
	local Vector HitNormal,HitLocation,EndTrace,StartTrace,X,Y,Z,NewHitLocation;
	super.Tick(Deltatime);
	if(Owner == None)
		OffTorch();
		
	if(bTorchOn && Owner != None && s != None)
	{
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);	
		EndTrace = Pawn(Owner).Location + 10000* Vector(Pawn(Owner).ViewRotation);
		Trace(HitLocation,HitNormal,EndTrace,Pawn(Owner).Location, True);
		s.SetLocation(HitLocation-vector(Pawn(Owner).ViewRotation)*64);
	}
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{

		if(Other.isa('DeusExPlayer'))
		{
			DeusExPlayer(Owner).ClientMessage("Weapon can not be used on players.");
			return;
		}
			super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
	
}

function Destroyed()
{
	OffTorch();
	Super.destroyed();
}

defaultproperties
{
     InventoryGroup=1478564
     ItemName="Glock w/ Torch"
     beltDescription="GLOCK+"
	 bHasLaser=True
	 TorchRadius=7
	 TorchBrightness=70
}
