//=============================================================================
// JordanShea.
//=============================================================================
class eJordanShea extends DXEnemy;

function Bool HasTwoHandedWeapon()
{
	return False;
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
     CarcassType=Class'DeusEx.JordanSheaCarcass'
     WalkingSpeed=0.300000
     bImportant=True
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponSawedOffShotgun')
     InitialInventory(1)=(Inventory=Class'DeusEx.AmmoShell',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=1.000000
     bIsFemale=True
     GroundSpeed=200.000000
     Health=400
     HealthHead=400
     HealthTorso=400
     HealthLegLeft=400
     HealthLegRight=400
     HealthArmLeft=400
     HealthArmRight=400
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JordanSheaTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JordanSheaTex0'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JordanSheaTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.JordanSheaTex1'
     CollisionRadius=20.000000
     CollisionHeight=43.000000
     BindName="JordanShea"
     FamiliarName="Jordan Shea"
     UnfamiliarName="Jordan Shea"
}
