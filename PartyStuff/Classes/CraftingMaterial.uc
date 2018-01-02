class CraftingMaterial extends deusexpickup;

var() class<DeusExDecoration> DecoResult;
var() class<Inventory> InvResult;
var() bool bInv, bDeco;
var() int NumNeeded;
var() string DispStr;
var() bool bIngredient;

replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
DispStr;
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
}

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local inventory inv;
		local vector v2;
		Super.BeginState();
			if(NumCopies >= NumNeeded && OtherRequirements() && !bIngredient)
			{
				v2 = Owner.Location;
				v2.Z += Owner.collisionHeight + 50;
				if(DecoResult != None)
					Spawn(DecoResult,,,Owner.Location);
					
				if(InvResult != None)
				{
					inv = Spawn(Invresult,,,v2);
					inv.Frob(DeusExPlayer(Owner),None);
					inv.Destroy();
				}
				Numcopies-=NumNeeded;
				if(Numcopies <= 0)
					Destroy();
			}
		GotoState('DeActivated');
	}
Begin:
}

function bool OtherRequirements()
{
	return true;
}

function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local string str;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	winInfo.AppendText("Materials");

	// Print the number of copies
	str = CountLabel @ String(NumCopies);
	winInfo.AppendText(winInfo.CR() $ winInfo.CR() $ str);

	return True;
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

simulated event RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local Actor CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
		local vector loc, line;
			local String KeyName, Alias, curKeyName;
	local int i;
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
			//	bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				//Canvas.Style = ERenderStyle.STY_Translucent;
				Canvas.DrawColor.R = 255;
				Canvas.DrawColor.G = 250;
				Canvas.DrawColor.B = 255;
				Canvas.Font = Canvas.SmallFont;

				Canvas.DrawText("      "@DispStr);
	}
		//	else
			//	bOwnsCrossHair = False; // Only for compatibility with HDX50		
}

defaultproperties
{
    Mesh=LodMesh'DeusExItems.GlassFragment1'
    maxCopies=20
    M_Activated=""
    bBreakable=False
        bActivatable=True
    bCanHaveMultipleCopies=True
    ItemName="Material shard"
    Description="A material"
    beltDescription="CRAFT"
    PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.GlassFragment1'
     PickupViewMesh=LodMesh'DeusExItems.GlassFragment1'
     ThirdPersonMesh=LodMesh'DeusExItems.GlassFragment1'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     CollisionRadius=2
     CollisionHeight=2
     	 style=sty_translucent
     Skin=Texture'DeusExItems.Skins.GlassFragmentTex1'
     Icon=Texture'BeltIconCrafting'
}
