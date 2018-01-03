//=============================================================================
// MaggieChow.
//=============================================================================
class eMaggieChow extends DXEnemy;

function Bool HasTwoHandedWeapon()
{
	return False;
}

defaultproperties
{
     scoreCredits=300
     CarcassType=Class'DeusEx.MaggieChowCarcass'
     WalkingSpeed=0.320000
     bImportant=True
     InitialAlliances(3)=(AllianceName=eTerrorist,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=JCDenton,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=PaulDenton,AllianceLevel=-1.000000)
     InitialAlliances(6)=(AllianceName=Rogue,AllianceLevel=-1.000000)
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'WeaponNanoSword')
     walkAnimMult=0.650000
     bIsFemale=True
     GroundSpeed=120.000000
     BaseEyeHeight=38.000000
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex5'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SkinTex5'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LegsTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaggieChowTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.MaggieChowTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=43.000000
     BindName="MaggieChow"
     FamiliarName="Maggie Chow"
     UnfamiliarName="Maggie Chow"
}
