//=============================================================================
// WIB.
//=============================================================================
class eWIB2 extends DXEnemy;

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	GoToState('Killswitch');
}

function PlayDying(name damageType, vector hitLoc)
{
}

defaultproperties
{
	sScanning(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1435'
	sScanning(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1411'
	sScanning(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1412'
	sScanning(3)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1400'
	sScanning(4)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1402'
	sTargetAcquired(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1429'
	sTargetAcquired(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1428'
	sTargetAcquired(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1431'
	sTargetLost(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1436'
	sTargetLost(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1435'
	sTargetLost(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1434'
	sCriticalDamage(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1439'
	sCriticalDamage(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1405'
	sCriticalDamage(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1404'
	sAreaSecure(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1426'
	sAreaSecure(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1425'
	sAreaSecure(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1427'
	sBossArmourDown=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1383'
	sBossArmourBack=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1381'
	sMedkitUsed=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1430'
	sCallingBackup(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1387'
	sCallingBackup(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1388'
	sCallingBackup(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1389'
	sRespondBackup(0)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1388'
	sRespondBackup(1)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1381'
	sRespondBackup(2)=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1380'
	sHunting=sound'DeusExConAudioAIBarks.ConAudioAIBarks_1378'
		bPlaySound=True
		Medkits=1
		bVoiced=True
		bHasCloakX=True
     MinHealth=0.000000
     CarcassType=Class'DeusEx.WIBCarcass'
     WalkingSpeed=0.300000
     CloseCombatMult=0.500000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponNanoSword')
     walkAnimMult=0.870000
     bIsFemale=True
     GroundSpeed=200.000000
     Health=400
     HealthHead=400
     HealthTorso=400
     HealthLegLeft=400
     HealthLegRight=400
     HealthArmLeft=400
     HealthArmRight=400
     Mesh=LodMesh'DeusExCharacters.GFM_Trench'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.WIBTex0'
     MultiSkins(1)=Texture'MIBTex17'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex2'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JaimeReyesTex1'
     MultiSkins(5)=Texture'MIBTex17'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex3'
     CollisionHeight=47.299999
     BindName="WIB"
     FamiliarName="Woman In Black"
     UnfamiliarName="Woman In Black"
}
