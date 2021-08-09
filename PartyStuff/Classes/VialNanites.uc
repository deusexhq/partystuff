//-----------------------------------------------------------
//
//-----------------------------------------------------------
class VialNanites extends CraftingMaterial;

function bool OtherRequirements()
{
	local WeaponNanoSword GS;
	local WeaponNanoSword2 GS2;
	local bool bFound, bFound2;
	
	foreach AllActors(class'WeaponNanosword',GS)
		if(GS.Owner == Owner && GS.ItemName=="Dragon's Tooth Sword")
			bFound=True;
			

	foreach AllActors(class'WeaponNanosword2',GS2)
		if(GS2.Owner == Owner && GS.ItemName=="Dragon's Tooth Sword")
			bFound2=True;
	
	if(bFound)
	{
		foreach AllActors(class'WeaponNanosword',GS)
			if(GS.Owner == Owner && GS.ItemName=="Dragon's Tooth Sword")
				GS.Destroy();
		return True;
	}
	if(bFound2)
	{
		foreach AllActors(class'WeaponNanosword2',GS2)
			if(GS2.Owner == Owner && GS2.ItemName=="Dragon's Tooth Sword")
				GS2.Destroy();
		return True;
	}
}

defaultproperties
{
     InvResult=Class'PartyStuff.WeaponAugrist'
     NumNeeded=7
     DispStr="Requires 7x Vial of Nanites, 1x Dragon's Tooth Sword to make Augrist"
     ItemName="Vial of Concentrated Nanites"
     PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
     Icon=Texture'PGAssets.Icons.BeltIconCraftingFlask'
     largeIcon=Texture'DeusExUI.Icons.LargeIconVialAmbrosia'
     largeIconWidth=18
     largeIconHeight=44
     beltDescription="NANITES"
     Mesh=LodMesh'DeusExItems.BioCell'
     MultiSkins(1)=Texture'PGAssets.Skins.wtf'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=2.000000
     Buoyancy=4.000000
}
