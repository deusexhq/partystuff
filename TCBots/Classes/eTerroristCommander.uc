//=============================================================================
// TerroristCommander.
//=============================================================================
class eTerroristCommander extends DXEnemy;

function Bool HasTwoHandedWeapon()
{
	return False;
}

defaultproperties
{
     CarcassType=Class'DeusEx.TerroristCommanderCarcass'
     WalkingSpeed=0.210000
     bImportant=True
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.750000
     GroundSpeed=180.000000
     Health=400
     HealthHead=400
     HealthTorso=400
     HealthLegLeft=400
     HealthLegRight=400
     HealthArmLeft=400
     HealthArmRight=400
     Mesh=LodMesh'DeusExCharacters.GM_Trench_F'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.BartenderTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.BartenderTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JuanLebedevTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="TerroristCommander"
     FamiliarName="Terrorist Commander"
     UnfamiliarName="Terrorist Commander"
}
