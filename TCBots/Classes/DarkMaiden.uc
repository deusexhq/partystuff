//=============================================================================
// DarkMaiden.
//=============================================================================
class DarkMaiden extends DXHumanMilitary;

function Bool HasTwoHandedWeapon()
{
	return False;
}

function float ShieldDamage(name damageType)
{
	if ( (damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') )
		return 0.0;
        	else if ( (damageType == 'Flamed') || (damageType == 'Poison') || (damageType == 'PoisonEffect') || (damageType == 'Radiation') )
                	return 0.1;
	else if ( (damageType == 'Shocked') || (damageType == 'KnockedOut') || (damageType == 'Fell') )
                	return 0.5;
      	else
		return Super.ShieldDamage(damageType);
}

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
		sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_31'
	sTargetAcquired=sound'DeusExConAudioAIBarks.ConAudioAIBarks_19'
	sTargetLost=sound'DeusExConAudioAIBarks.ConAudioAIBarks_15'
	sCriticalDamage=sound'DeusExConAudioAIBarks.ConAudioAIBarks_14'
	sAreaSecure=sound'DeusExConAudioAIBarks.ConAudioAIBarks_9'
	sBossArmourDown=sound'DeusExConAudioAIBarks.ConAudioAIBarks_11'
	sBossArmourBack=sound'DeusExConAudioAIBarks.ConAudioAIBarks_13'
	sMedkitUsed=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sCallingBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_20'
	sRespondBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sHunting=sound'DeusExConAudioAIBarks.ConAudioAIBarks_23'
     scoreCredits=200
     BaseAccuracy=-0.250000
     CarcassType=Class'DarkMaidenCarcass'
     WalkingSpeed=0.280000
     bShowPain=False
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
     SurprisePeriod=0.000000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponStealthPistol')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo10mm',Count=36)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponMiniCrossbow')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoDartPoison',Count=12)
     InitialInventory(4)=(Inventory=Class'DeusEx.WeaponNanoSword')
     BurnPeriod=0.000000
     bIsFemale=True
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=750
     CombatStyle=-0.500000
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.LensesTex5'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.NicoletteDuClareTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.TiffanySavageTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.TiffanySavageTex1'
     CollisionHeight=47.299999
     BindName="DarkMaiden"
     FamiliarName="Dark Maiden"
     UnfamiliarName="Dark Maiden"
     bVisionImportant=False
}
