//=============================================================================
// MIB.
//=============================================================================
class Lucifer extends DXEnemy;

function Bool HasTwoHandedWeapon()
{
	return False;
}

function float ShieldDamage(name damageType)
{
	if ( (damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') )
		return 0.0;
        	else if ( (damageType == 'Flamed') || (damageType == 'Poison') || (damageType == 'PoisonEffect') || (damageType == 'Radiation') )
                	return 0.0;
	else if ( (damageType == 'Shocked') || (damageType == 'KnockedOut') || (damageType == 'Fell') )
                	return 0.0;
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
     MinHealth=0.000000
     WalkingSpeed=0.213333
     CloseCombatMult=0.500000
     GroundSpeed=180.000000
     Health=900
     HealthHead=900
     HealthTorso=900
     HealthLegLeft=900
     HealthLegRight=900
     HealthArmLeft=900
     HealthArmRight=900
	 InitialInventory(0)=(Inventory=Class'WeaponNanoSword')
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JCDentonTex7'
     MultiSkins(1)=Texture'SatanTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JCDentonTex7'
     MultiSkins(3)=Texture'SatanTex1'
     MultiSkins(4)=Texture'SatanTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionHeight=52.250000
     BindName="Lucifer"
     FamiliarName="Lucifer"
     UnfamiliarName="Lucifer"
}
