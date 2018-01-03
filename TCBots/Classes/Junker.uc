//=============================================================================
// SecurityBot2.
//=============================================================================
class Junker extends DXRobot;

function BeginPlay()
{
	Super.BeginPlay();

MultiSkins[1] = Texture'junker';
}

function PlayDisabled()
{
	local int rnd;

	rnd = Rand(3);
	if (rnd == 0)
		TweenAnimPivot('Disabled1', 0.2);
	else if (rnd == 1)
		TweenAnimPivot('Disabled2', 0.2);
	else
		TweenAnimPivot('Still', 0.2);
}

defaultproperties
{
	dPitch=32
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=rCiv,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Security,AllianceLevel=-1.000000)
     SearchingSound=Sound'DeusExSounds.Robot.SecurityBot2Searching'
     SpeechTargetAcquired=Sound'TurretLocked'
     SpeechTargetLost=Sound'CloakDown'
     SpeechOutOfAmmo=Sound'CloakDown'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.SecurityBot2CriticalDamage'
     SpeechScanning=Sound'Spark1'
     EMPHitPoints=100
     explosionSound=Sound'DeusExSounds.Robot.SecurityBot2Explode'
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponRobotMachinegun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=50)
     WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk'
     GroundSpeed=95.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=250
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SecurityBot2'
     CollisionRadius=62.000000
     CollisionHeight=58.279999
     Mass=800.000000
     Buoyancy=100.000000
     BindName="Junker"
     FamiliarName="Junker"
     UnfamiliarName="Junker"
}
