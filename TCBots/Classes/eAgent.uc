//=============================================================================
// SamCarter.
//=============================================================================
class eAgent extends DXEnemy;

defaultproperties
{
     WalkingSpeed=0.300000
     bImportant=True
     bInvincible=False
     InitialInventory(0)=(Inventory=Class'WeaponAirgetb')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExItems.Skins.PinkMaskTex'
	MultiSkins(1)=Texture'DeusExCharacters.Skins.PantsTex5'
	MultiSkins(2)=Texture'DeusExCharacters.Skins.MIBTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JCDentonTex7'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Agent"
     FamiliarName="Agent"
     UnfamiliarName="Agent"
}
