//=============================================================================
// KarkianOld.
//=============================================================================
class Leviathan extends Karkian;


function ImpartMomentum(Vector momentum, Pawn instigatedBy)
{}

function bool FilterDamageType(Pawn instigatedBy, Vector hitLocation, Vector offset, Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Flamed') || (damageType == 'Burned'))
		return false;
	else
		return Super.FilterDamageType(instigatedBy, hitLocation, offset, damageType);
}

function bool AICanShoot(pawn target, bool bLeadTarget, bool bCheckReadiness, optional float throwAccuracy, optional bool bDiscountMinRange)
{
	return true;
}

defaultproperties
{
     MinHealth=100.000000
     WalkingSpeed=0.250000
     bShowPain=True
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Karkian,AllianceLevel=1.000000)
     GroundSpeed=300.000000
     WaterSpeed=200.000000
     Health=600
     AttitudeToPlayer=ATTITUDE_Hate
     DrawScale=3.500000
     CollisionRadius=220.000000
     CollisionHeight=130.000000
     Mass=1500.000000
     Buoyancy=800.000000
     RotationRate=(Yaw=50000)
     BindName="KarkianOld"
     FamiliarName="Leviathan"
     UnfamiliarName="Leviathan"
}
