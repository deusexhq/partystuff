class ChubBot extends DXRobot;

defaultproperties
{
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.MilitaryBotTargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.MilitaryBotTargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.MilitaryBotOutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.MilitaryBotCriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.MilitaryBotScanning'
     EMPHitPoints=40
     Saymsg="Can I has candy bar?"
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'WeaponRobotMachinegunF')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=24)
     InitialInventory(2)=(Inventory=Class'WeaponRobotRocketF')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoRocketRobot',Count=10)
     GroundSpeed=65.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=150
     UnderWaterTime=20.000000
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.MilitaryBot'
     DrawScale=0.400000
     Fatness=172
     SoundRadius=16
     SoundVolume=128
     CollisionRadius=34.000000
     CollisionHeight=32.000000
     Mass=500.000000
     Buoyancy=100.000000
     BindName="ChubBot"
     FamiliarName="ChubBot"
     UnfamiliarName="ChubBot"
}
