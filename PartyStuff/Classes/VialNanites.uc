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
	DispStr="Requires 7x Vial of Nanites, 1x Dragon's Tooth Sword to make Augrist"
	Invresult=class'PartyStuff.WeaponAugrist'
	NumNeeded=7
    ItemName="Vial of Concentrated Nanites"
    PlayerViewOffset=(X=30.00,Y=0.00,Z=-12.00),
    PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
    PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
    ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
    LandSound=Sound'DeusExSounds.Generic.GlassHit1'
    Icon=Texture'BeltIconCraftingFlask'
    largeIcon=Texture'DeusExUI.Icons.LargeIconVialAmbrosia'
    largeIconWidth=18
    largeIconHeight=44
    beltDescription="NANITES"
    Mesh=LodMesh'DeusExItems.BioCell'
    MultiSkins(1)=Texture'wtf'
    CollisionRadius=2.20
    CollisionHeight=4.89
    Mass=2.00
    Buoyancy=4.00
}
