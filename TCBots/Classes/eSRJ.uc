//=============================================================================
// Soldier.
//=============================================================================
class eSRJ extends DXEnemy;

defaultproperties
{
     CarcassType=Class'DeusEx.SoldierCarcass'
     WalkingSpeed=0.300000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SoldierTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SoldierTex2'
     MultiSkins(2)=Texture'SoldierSRJTex'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SoldierTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="eSRJ"
     FamiliarName="SRJ Soldier"
     UnfamiliarName="SRJ Soldier"
}
