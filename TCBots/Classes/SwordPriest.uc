//=============================================================================
// BobPage.
//=============================================================================
class SwordPriest extends DXHumanMilitary;

function float ModifyDamage(int Damage, Pawn instigatedBy, Vector hitLocation,
                            Vector offset, Name damageType)
{
	if ((damageType == 'Stunned') || (damageType == 'KnockedOut'))
		return 0;
	else
		return Super.ModifyDamage(Damage, instigatedBy, hitLocation, offset, damageType);
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}

defaultproperties
{
     CarcassType=Class'SwordPriestCarcass'
     InitialInventory(0)=(Inventory=Class'WeaponAugrist')
     WalkingSpeed=0.213333
     bImportant=True
     GroundSpeed=180.000000
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'JCDentonTex7'
     MultiSkins(1)=Texture'Pantstex5'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.BobPageTex0'
     MultiSkins(3)=Texture'PageChurchSwordTex1'
     MultiSkins(4)=Texture'PageChurchSwordTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="SwordPriest"
     FamiliarName="Priest of the Sword"
     UnfamiliarName="Priest of the Sword"
}
