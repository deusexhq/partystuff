//=============================================================================
// DarkMaiden.
//=============================================================================
class Carl extends DXHumanMilitary;

function PlayDying(name damageType, vector hitLoc)
{
}

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

	event Landed(vector HitNormal)
	{
		SetPhysics(PHYS_Walking);
	}

	function BeginState()
	{
		EnableCheckDestLoc(false);
		StandUp();

		AIClearEventCallback('Futz');
		AIClearEventCallback('MegaFutz');
		AIClearEventCallback('Player');
		AIClearEventCallback('WeaponDrawn');
		AIClearEventCallback('LoudNoise');
		AIClearEventCallback('WeaponFire');
		AIClearEventCallback('Carcass');
		AIClearEventCallback('Distress');

		bInterruptState = false;
		BlockReactions(true);
		bCanConverse = False;
		bStasis = False;
		SetDistress(true);
		DeathTimer = 0;
	}

Begin:
	DesiredRotation.Pitch = 0;
	DesiredRotation.Roll  = 0;
	FinishAnim();
	Acceleration = vect(0,0,0);
	GoToState('Killswitch');
}


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

defaultproperties
{
AllyClass=class'SecuritySniper'
AllianceGroup="Admins"
	tScanning="My wood senses are tingling."
	tTargetAcquired="You = found."
	tTargetLost="Ffs, where are you hiding."
	tCriticalDamage="You broke my chopstick."
	tAreaSecure="*whistles*"
	tBossArmourDown="Nooooooooo!"
	tBossArmourBack="Wood Armour is ready to rock."
	tMedkitUsed="My medkit is augmented."
	tCallingBackup="Chop chop!"
	bBossArmour=True
	BossArmour=300
	Medkits=2
     BaseAccuracy=-0.250000
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
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Male1Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.GordonQuickTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JaimeReyesTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.GordonQuickTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionHeight=47.299999
     BindName="Carl"
     FamiliarName="Carl Roberts"
     UnfamiliarName="Carl Roberts"
     bVisionImportant=False
}
