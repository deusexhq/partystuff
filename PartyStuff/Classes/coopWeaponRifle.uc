//=============================================================================
// WeaponAssaultGun.
//=============================================================================
class coopWeaponRifle extends WeaponRifle;

function GiveTo( pawn Other )
{
    super.Giveto(Other);
	Other.ClientMessage("Special Weapon: Can't be used on Players.");
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

defaultproperties
{
     InventoryGroup=100
     ItemName="Rifle"
     beltDescription="RIFLE"
}
