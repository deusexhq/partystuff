//=============================================================================
// SecurityForce.
//=============================================================================
class Scoundrel extends DXEnemy;

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	GoToState('Killswitch');
	BroadcastMessage("|P2Scoundrel defeated.");
}

function PlayDying(name damageType, vector hitLoc)
{
}

defaultproperties
{
     scoreCredits=9000
     WalkingSpeed=0.213333
     InitialAlliances(2)=(AllianceName=Wildcat)
     InitialAlliances(3)=(AllianceName=Agentsmith,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=KaiAlt,AllianceLevel=-1.000000)
     InitialAlliances(6)=(AllianceName=Security,AllianceLevel=-1.000000)
     InitialInventory(0)=(Inventory=Class'WeaponNanosword')
     InitialInventory(1)=(Inventory=Class'WeaponShuriken')
     walkAnimMult=0.750000
     GroundSpeed=220.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     HealthHead=900
     HealthTorso=900
     HealthLegLeft=900
     HealthLegRight=900
     HealthArmLeft=900
     HealthArmRight=900
     Alliance=Scoundrel
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MIBTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JoJoFineTex2'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JockTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Scoundrel"
     FamiliarName="Scoundrel"
     UnfamiliarName="Scoundrel"
}
