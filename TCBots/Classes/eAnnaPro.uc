//=============================================================================
// WIB.
//=============================================================================
class eAnnaPro extends DXEnemy;

function Bool HasTwoHandedWeapon()
{
	return False;
}

function float ShieldDamage(name damageType)
{
	// handle special damage types
	if ((damageType == 'Flamed') || (damageType == 'Burned') || (damageType == 'Stunned') ||
	    (damageType == 'KnockedOut'))
		return 0.0;
	else if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'HalonGas') ||
			(damageType == 'Radiation') || (damageType == 'Shocked') || (damageType == 'Poison') ||
	        (damageType == 'PoisonEffect'))
		return 0.1;
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
AllyClass=class'eWIB2'
	sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_31'
	sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_35'
	sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_36'
	sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_11'
	sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_28'
	sTargetAcquired=sound'DeusExConAudioAIBarks.ConAudioAIBarks_41'
	sTargetAcquired=sound'DeusExConAudioAIBarks.ConAudioAIBarks_42'
	sTargetAcquired=sound'DeusExConAudioAIBarks.ConAudioAIBarks_19'
	sTargetLost=sound'DeusExConAudioAIBarks.ConAudioAIBarks_28'
	sTargetLost=sound'DeusExConAudioAIBarks.ConAudioAIBarks_29'
	sTargetLost=sound'DeusExConAudioAIBarks.ConAudioAIBarks_15'
	sCriticalDamage=sound'DeusExConAudioAIBarks.ConAudioAIBarks_14'
	sCriticalDamage=sound'DeusExConAudioAIBarks.ConAudioAIBarks_26'
	sCriticalDamage=sound'DeusExConAudioAIBarks.ConAudioAIBarks_26'
	sAreaSecure=sound'DeusExConAudioAIBarks.ConAudioAIBarks_15'
	sAreaSecure=sound'DeusExConAudioAIBarks.ConAudioAIBarks_12'
	sAreaSecure=sound'DeusExConAudioAIBarks.ConAudioAIBarks_9'
	sBossArmourDown=sound'DeusExConAudioAIBarks.ConAudioAIBarks_11'
	sBossArmourBack=sound'DeusExConAudioAIBarks.ConAudioAIBarks_13'
	sMedkitUsed=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sCallingBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_20'
	sCallingBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_19'
	sCallingBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sRespondBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sRespondBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sRespondBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_18'
	sHunting=sound'DeusExConAudioAIBarks.ConAudioAIBarks_23'
	bVoiced=True
		bPlaySound=True
	bHasCloakX=True
	bBossArmour=True
	bHasADS=True
	AdsUnlimited=True
	BossArmour=350
     MinHealth=100
     CarcassType=Class'DeusEx.WIBCarcass'
	 bHasCloak=True
     WalkingSpeed=0.300000
     CloseCombatMult=0.500000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponNanosword')
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
     MultiSkins(0)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(1)=Texture'MIBTex17'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex2'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JaimeReyesTex1'
     MultiSkins(5)=Texture'MIBTex17'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex3'
     CollisionHeight=47.299999
     BindName="eAnnaPro"
     FamiliarName="Anna Navarre"
     UnfamiliarName="Anna Navarre"
}
