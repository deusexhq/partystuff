//=============================================================================
// SecurityForce.
//=============================================================================
class Security extends DXHumanMilitary;

defaultproperties
{
     CarcassType=Class'SecurityForceCarcass'
     Orders=Standing
	 	 InitialAlliances(0)=(AllianceName=DarkoE,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Experiment,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Mal,AllianceLevel=-1.000000)
	      bKeepWeaponDrawn=True
     WalkingSpeed=0.213333
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.750000
     GroundSpeed=220.000000
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.GarySavageTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SecretServiceTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.GarySavageTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SecretServiceTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.SecretServiceTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.LensesTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Security"
     FamiliarName="Security Agent"
     UnfamiliarName="Security Agent"
}
