class KarkianSkel extends Karkian;

function ImpartMomentum(Vector momentum, Pawn instigatedBy)
{}

function Carcass SpawnCarcass()
{	
	bBlockActors=False;
	Destroy();
	return None;
}

defaultproperties
{
    MinHealth=100.00
    WalkingSpeed=0.25
    bShowPain=True
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Forgotten,AllianceLevel=1.000000)
     InitialAlliances(2)=(AllianceName=Security,AllianceLevel=-1.000000)
	GroundSpeed=300.00
    WaterSpeed=100.00
	fatness=1
    Health=600
    AttitudeToPlayer=1
    Skin=Texture'karkianskel'
	Texture=Texture'karkianskel'
    DrawScale=1.20
    CollisionRadius=64.00
    CollisionHeight=45.60
    Mass=800.00
    Buoyancy=800.00
    RotationRate=(Pitch=4096,Yaw=50000,Roll=3072),
    BindName="KarkianOld"
    FamiliarName="Skeletal Karkian"
    UnfamiliarName="Skeletal Karkian"
}