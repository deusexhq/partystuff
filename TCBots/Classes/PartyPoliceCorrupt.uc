//=============================================================================
// SecurityForce.
//=============================================================================
class PartyPoliceCorrupt extends DXHumanMilitary;

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	GoToState('Killswitch');
}

function PlayDying(name damageType, vector hitLoc)
{
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
	tScanning=""
	tTargetAcquired="Gotcha!"
	tTargetLost="You can't hide from the LAW!"
	tCriticalDamage=""
	tAreaSecure="Noone here..."
	tBossArmourDown="The armour was a let down, huh."
	tBossArmourBack="Back to 100%."
	tMedkitUsed="Using meds."
	tCallingBackup="Guys, get over here!"
	bBossArmour=True
	BossArmour=300
	Medkits=2
     InitialAlliances(0)=(AllianceName=DarkoE,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Fits,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Mango,AllianceLevel=-1.000000)
	 InitialAlliances(3)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=DarkMaiden,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=Forgotten,AllianceLevel=-1.000000)
	 InitialAlliances(6)=(AllianceName=PartyPolice,AllianceLevel=-1.000000)
     Orders=Standing
     WalkingSpeed=0.213333
     InitialInventory(0)=(Inventory=Class'WeaponDisarmer')
     walkAnimMult=0.750000
     GroundSpeed=220.000000
     Texture=Texture'DeusExCharacters.Skins.VisorTex1'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.RiotCopTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.RiotCopTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.RiotCopTex3'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
	 Health=1750
     CombatStyle=-0.500000
     HealthHead=1750
     HealthTorso=1750
     HealthLegLeft=1750
     HealthLegRight=1750
     HealthArmLeft=1750
     HealthArmRight=1750
     BindName="PartyPoliceCorrupt"
     FamiliarName="Corrupt Party Police"
     UnfamiliarName="Corrupt Party Police"
}
