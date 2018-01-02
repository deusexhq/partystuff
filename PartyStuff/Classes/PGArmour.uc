//=============================================================================
// AdaptiveArmor.
//=============================================================================
class PGArmour extends DeusExPickup;

var() int Dur, Def;
var() bool bResistFire, bResistEMP, bResistPoison;
var int rDur, rDef;

replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
rDur, rdef;
}

function BeginPlay()
{
	rDur = Dur;
	rdef = Def;
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
	local string str;
	
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
				//bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				//Canvas.Style = ERenderStyle.STY_Translucent;
				Canvas.DrawColor.R = 255;
				Canvas.DrawColor.G = 250;
				Canvas.DrawColor.B = 255;
				Canvas.Font = Canvas.SmallFont;
				
				if(bResistFire)
					str = str@"- Resists Flame";
					
				if(bResistPoison)
					str = str@"- Resists Poison";
				
				if(bResistEMP)
					str = str@"- Resists EMP";
					
				Canvas.DrawText("      Armour: "$rDef$" - Durability: "$rDur$str);
	}
			//else
				//bOwnsCrossHair = False; // Only for compatibility with HDX50		
}


simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}
defaultproperties
{
	Dur=5
	Def=5
     ItemName="Basic Armour"
     ItemArticle="some"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.AdaptiveArmor'
     PickupViewMesh=LodMesh'DeusExItems.AdaptiveArmor'
     ThirdPersonMesh=LodMesh'DeusExItems.AdaptiveArmor'
     Charge=500
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconArmorAdaptive'
     largeIcon=Texture'DeusExUI.Icons.LargeIconArmorAdaptive'
     largeIconWidth=35
     largeIconHeight=49
     Description="Integrating woven fiber-optics and an advanced computing system, thermoptic camo can render an agent invisible to both humans and bots by dynamically refracting light and radar waves; however, the high power drain makes it impractial for more than short-term use, after which the circuitry is fused and it becomes useless."
     beltDescription="ARMOUR"
     Mesh=LodMesh'DeusExItems.AdaptiveArmor'
     CollisionRadius=11.500000
     CollisionHeight=13.810000
     Mass=30.000000
     Buoyancy=20.000000
}
