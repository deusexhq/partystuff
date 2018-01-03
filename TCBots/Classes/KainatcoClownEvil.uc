//=============================================================================
// SecurityForce.
//=============================================================================
class KainatcoClownEvil extends DXEnemy;

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
     scoreCredits=200
     WalkingSpeed=0.213333
     InitialAlliances(2)=(AllianceName=DarkoE,AllianceLevel=-1.000000)
     InitialAlliances(3)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Carl,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=Security,AllianceLevel=-1.000000)
     InitialInventory(0)=(Inventory=Class'WeaponPistol')
     InitialInventory(1)=(Inventory=Class'WeaponSawedOffShotgun')
     walkAnimMult=0.750000
     GroundSpeed=220.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     Alliance=KainatcoClownEvil
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(1)=Texture'SOLTex1'
     MultiSkins(2)=Texture'SOLTex2'
     MultiSkins(3)=Texture'SOLTex3'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.GrayMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="KainatcoClownEvil"
     FamiliarName="Clown Agent"
     UnfamiliarName="Clown Agent"
}
