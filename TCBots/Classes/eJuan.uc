//=============================================================================
// JuanLebedev.
//=============================================================================
class eJuan extends DXEnemy;

defaultproperties
{
     CarcassType=Class'DeusEx.JuanLebedevCarcass'
     WalkingSpeed=0.213333
     bImportant=True
     BaseAssHeight=-23.000000
     GroundSpeed=180.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponSawedOffShotgun')
     InitialInventory(1)=(Inventory=Class'DeusEx.AmmoShell',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCrowbar')
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JuanLebedevTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JuanLebedevTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JuanLebedevTex3'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JuanLebedevTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JuanLebedevTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JuanLebedevTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="eJuan"
     FamiliarName="Juan Lebedev"
     UnfamiliarName="Juan Lebedev"
}
