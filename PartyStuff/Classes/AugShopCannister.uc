//=============================================================================
// AugShopCannister
//
// Specific aug info (for reference):
///////////////////////////////////////////////////////////////////////////////
//
// AugBallistic - c700
// AugSpeed - c850
// //AugAqualung - c1 //A crap joke.
// AugDefense (ADS) - c450
// AugEMP (EMP Def') - c250
// AugCloak - c1200
// AugEnviro - c200
// AugVision - c500
// AugRadarTrans - c500
// AugHealing - c800
// AugStealth (Run Silent) - c200
// AugMuscle - c150 (No uses yet? :S)
// AugTarget - c450
// AugPower (recirc') - c300
// AugCombat - c400
// AugDrone - c450
// AugShield (Energy shield) - c200
//=============================================================================
class AugShopCannister extends DeusExDecoration;

Var() int AugPrice;
Var() Class<Augmentation> AugInCan;
var() string AugCanName;

//function BeginPlay()
//{
//	ItemName = ""$AugCanName@" Aug|p7c("$AugPrice; //Stupid override means I can't do it this easily. Oh well; at least with subclasses you can summon them
//}

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

	if(DeusExPlayer(Frobber).Credits >= AugPrice)
	{
		DeusExPlayer(Frobber).Credits -= AugPrice;
		DeusExPlayer(Frobber).ClientMessage("|p7You bought the aug for c("$AugPrice$").");
		DeusExPlayer(Frobber).AugmentationSystem.GivePlayerAugmentation(AugInCan);
		DeusExPlayer(Frobber).AugmentationSystem.GivePlayerAugmentation(AugInCan);
	}
	else
	{
		DeusExPlayer(Frobber).ClientMessage("|p2You can't afford that.");
	}
}

defaultproperties
{
    bInvincible=True
    ItemName="Why is this default"
    bPushable=False
    Mesh=LodMesh'DeusExItems.AugmentationCannister'
    CollisionRadius=4.31
    CollisionHeight=10.24
    Mass=10.00
    Buoyancy=12.00
}
