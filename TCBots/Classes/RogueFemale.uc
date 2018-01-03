//=============================================================================
// SecurityForce.
//=============================================================================
class RogueFemale extends DXEnemy;

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
     scoreCredits=300
     WalkingSpeed=0.213333
     InitialAlliances(2)=(AllianceName=Wildcat)
     InitialAlliances(3)=(AllianceName=Agentsmith,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=KaiAlt,AllianceLevel=-1.000000)
     InitialAlliances(6)=(AllianceName=Security,AllianceLevel=-1.000000)
     InitialInventory(0)=(Inventory=Class'WeaponNanosword')
     InitialInventory(1)=(Inventory=Class'WeaponShuriken')
     walkAnimMult=0.750000
     bIsFemale=True
     GroundSpeed=220.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     HealthHead=850
     HealthTorso=850
     HealthLegLeft=850
     HealthLegRight=850
     HealthArmLeft=850
     HealthArmRight=850
     Alliance=Rogue
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GFM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.WIBTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JoJoFineTex2'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JockTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Rogue"
     FamiliarName="Rogue"
     UnfamiliarName="Rogue"
}
