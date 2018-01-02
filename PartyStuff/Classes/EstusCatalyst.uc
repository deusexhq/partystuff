class EstusCatalyst extends CraftingMaterial;

function bool OtherRequirements()
{
	local GlassShard GS;
	local Medkit m;
	local int gi, mi;
	
	foreach AllActors(class'GlassShard',GS)
		if(GS.Owner == Owner)
			gi = gs.NumCopies;
			

	foreach AllActors(class'Medkit',m)
		if(m.Owner == Owner)
			mi = m.NumCopies;
	
	DeusExPlayer(Owner).ClientMessage("[Extra ingredients] You have "$gi$" Glass Shards and "$mi$" Medkits. 5 of each required.");
	if(gi >= 5 && mi >= 5)
	{
		foreach AllActors(class'GlassShard',GS)
			{
				if(GS.Owner == Owner)
					{
						gs.NumCopies-=5;
						if(gs.NumCopies <= 0)
							GS.Destroy();
					}
			}
		
		foreach AllActors(class'Medkit',m)
			{
				if(m.Owner == Owner)
					{
						m.NumCopies-=5;
						if(m.NumCopies <= 0)
							m.Destroy();
					}
			}
		return True;
	}
}

defaultproperties
{
	DispStr="Requires 1x Catalyst, 5x Glass Shard, 5x Medkit to make Estus"
	NumNeeded=1
    CollisionRadius=4.20
    CollisionHeight=7.45
    Mesh=LodMesh'DeusExDeco.Flask'
     PlayerViewMesh=LodMesh'DeusExDeco.Flask'
     PickupViewMesh=LodMesh'DeusExDeco.Flask'
     ThirdPersonMesh=LodMesh'DeusExDeco.Flask'
	ItemName="Estus Catalyst"
	InvResult=class'Estus'
	beltDescription="CATALYST"
	Icon=Texture'BeltIconCraftingFlask'
}
