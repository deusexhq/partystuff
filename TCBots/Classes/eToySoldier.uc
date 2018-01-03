//=============================================================================
// Soldier.
//=============================================================================
class eToySoldier extends DXEnemy;

defaultproperties
{
     CarcassType=None
     WalkingSpeed=0.300000
     InitialInventory(0)=(Inventory=Class'WeaponToyAssault')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=120)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.780000
     GroundSpeed=60.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SoldierTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SoldierTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SoldierTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SoldierTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.SoldierTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=5.000000
     CollisionHeight=10.000000
	 Drawscale=0.2
     BindName="ToySoldier"
     FamiliarName="Toy Soldier"
     UnfamiliarName="Toy Soldier"
}
