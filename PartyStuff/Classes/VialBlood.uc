//-----------------------------------------------------------
//
//-----------------------------------------------------------
class VialBlood extends CraftingMaterial;

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
	DispStr="Requires 1x Vial of Blood, 1x Dragon's Tooth Sword to make Blood Sword"
	Invresult=class'PartyStuff.WeaponBloodSword'
	NumNeeded=1
    ItemName="Vial of Blood"
    PlayerViewOffset=(X=30.00,Y=0.00,Z=-12.00),
    PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
    PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
    ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
    LandSound=Sound'DeusExSounds.Generic.GlassHit1'
    Icon=Texture'BeltIconCraftingFlask'
    largeIcon=Texture'DeusExUI.Icons.LargeIconVialAmbrosia'
    largeIconWidth=18
    largeIconHeight=44
    beltDescription="BLOOD"
    Mesh=LodMesh'DeusExItems.BioCell'
    MultiSkins(1)=Texture'DeusExDeco.Skins.AlarmLightTex3'
    CollisionRadius=2.20
    CollisionHeight=4.89
    Mass=2.00
    Buoyancy=4.00
}
