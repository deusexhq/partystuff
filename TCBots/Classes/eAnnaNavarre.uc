//=============================================================================
// AnnaNavarre.
//=============================================================================
class eAnnaNavarre extends DXEnemy;

function Bool HasTwoHandedWeapon()
{
	return False;
}

function float ModifyDamage(int Damage, Pawn instigatedBy, Vector hitLocation,
                            Vector offset, Name damageType)
{
	if ((damageType == 'Stunned') || (damageType == 'KnockedOut') || (damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return 0;
	else
		return Super.ModifyDamage(Damage, instigatedBy, hitLocation, offset, damageType);
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
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
AllyClass=class'eWIB'
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
     scoreCredits=300
     CarcassType=Class'DeusEx.AnnaNavarreCarcass'
     WalkingSpeed=0.280000
     bImportant=True
     CloseCombatMult=0.500000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     BurnPeriod=5.000000
     bHasCloak=True
     CloakThreshold=100
     walkAnimMult=1.000000
     bIsFemale=True
     GroundSpeed=220.000000
     BaseEyeHeight=38.000000
     Health=700
     HealthHead=700
     HealthTorso=700
     HealthLegLeft=700
     HealthLegRight=700
     HealthArmLeft=700
     HealthArmRight=700
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.AnnaNavarreTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex9'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.AnnaNavarreTex1'
     CollisionHeight=47.299999
     BindName="AnnaNavarre"
     FamiliarName="Anna Navarre"
     UnfamiliarName="Anna Navarre"
}
