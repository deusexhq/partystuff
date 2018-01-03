//=============================================================================
// DarkMaiden.
//=============================================================================
class KaiAlt2 extends DXHumanMilitary;

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
AllyClass=class'Seventeen'
AllianceGroup="Admins"
	tScanning=""
	tTargetAcquired="Time to die."
	tTargetLost="You'll be back."
	tCriticalDamage="You'll regret that.."
	tAreaSecure="*sighs*"
	tBossArmourDown="I paid good money for that armour!"
	tBossArmourBack=""
	tMedkitUsed=""
	tCallingBackup=""
	bBossArmour=True
	BossArmour=800
	Medkits=2
     BaseAccuracy=-0.250000
     WalkingSpeed=0.280000
     bShowPain=False
	 	 	 InitialAlliances(0)=(AllianceName=DarkoE,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Experiment,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Mal,AllianceLevel=-1.000000)
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
     SurprisePeriod=0.000000
     BaseAssHeight=-18.000000
	      bKeepWeaponDrawn=True
     InitialInventory(0)=(Inventory=Class'WeaponAirgetB')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=36)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponMiniCrossbow')
     InitialInventory(3)=(Inventory=Class'DeusEx.AmmoDartPoison',Count=12)
     InitialInventory(4)=(Inventory=Class'DeusEx.WeaponNanoSword')
     BurnPeriod=0.000000
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
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex4'
     MultiSkins(1)=Texture'KaiAlt2Tex3'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.GordonQuickTex3'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaxChenTex1'
     MultiSkins(5)=Texture'KaiAlt2Tex3'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionHeight=47.299999
     BindName="Kai"
     FamiliarName="Kai"
     UnfamiliarName="Kai"
     bVisionImportant=False
}
