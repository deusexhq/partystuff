//=============================================================================
// MilitaryBot.
//=============================================================================
class eMilitaryBotMK2 extends DXRobot;

enum ESkinColor
{
	SC_UNATCO,
	SC_Chinese
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_UNATCO:		Skin = Texture'MilitaryBotTex1'; break;
		case SC_Chinese:	Skin = Texture'MilitaryBotTex2'; break;
	}
}

function Frob(Actor Frobber, Inventory frobWith) 
{
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
	SkinColor=SC_Chinese
	     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=rCiv,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Security,AllianceLevel=-1.000000)
     SearchingSound=Sound'DeusExSounds.Robot.MilitaryBotSearching'
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.MilitaryBotTargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.MilitaryBotTargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.MilitaryBotOutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.MilitaryBotCriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.MilitaryBotScanning'
     EMPHitPoints=200
     explosionSound=Sound'DeusExSounds.Robot.MilitaryBotExplode'
     WalkingSpeed=1.000000
     bEmitDistress=True
     	bHasADS=True
	AdsEnergy=10
     InitialInventory(0)=(Inventory=Class'WeaponRobotMachinegunF')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=24)
     InitialInventory(2)=(Inventory=Class'WeaponRobotRocketF')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoRocketRobot',Count=10)
     WalkSound=Sound'DeusExSounds.Robot.MilitaryBotWalk'
     GroundSpeed=44.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=600
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.MilitaryBot'
     CollisionRadius=80.000000
     CollisionHeight=79.000000
     Mass=2000.000000
     Buoyancy=100.000000
     RotationRate=(Yaw=10000)
     BindName="MilitaryBot"
     FamiliarName="Military Bot MK II"
     UnfamiliarName="Military Bot MK II"
}
