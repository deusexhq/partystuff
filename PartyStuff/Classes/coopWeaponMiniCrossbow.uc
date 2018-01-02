//=============================================================================
// WeaponMiniCrossbow.
//=============================================================================
class coopWeaponMiniCrossbow extends WeaponMiniCrossbow;

function GiveTo( pawn Other )
{
    super.Giveto(Other);
	Other.ClientMessage("Special Weapon: Can't be used on Players.");
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}


function Fire(float Value)
{
	local vector loc, line, HitLocation, hitNormal;
	local Actor Hitactor;
	
	loc = DeusExPlayer(Owner).Location;
	loc.Z += DeusExPlayer(Owner).BaseEyeHeight;
	line = Vector(DeusExPlayer(Owner).ViewRotation) * 10000;
	HitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
				
		if(!HitActor.isA('DeusExPlayer'))
		{
			super.Fire(Value);
		}
}

defaultproperties
{
     InventoryGroup=954324
     ItemName="Rusted Mini-Crossbow"
     beltDescription="RUSTED CRSSBW"
}
