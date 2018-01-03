//=============================================================================
// AdaptiveArmor.
//=============================================================================
class ReturnArmour extends DeusExPickup;
simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}
defaultproperties
{
     ItemName="Return Armour"
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
     beltDescription="RETURN"
	 MultiSkins(1)=FireTexture'Effects.UserInterface.WhiteStatic'
     Mesh=LodMesh'DeusExItems.AdaptiveArmor'
     CollisionRadius=11.500000
     CollisionHeight=13.810000
     Mass=30.000000
     Buoyancy=20.000000
}
