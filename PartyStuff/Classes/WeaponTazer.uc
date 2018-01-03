//=============================================================================
// WeaponTazer.
//=============================================================================
class WeaponTazer expands WeaponProd;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ((BeltSpot <= 9) && (BeltSpot >= 1));
}


function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
local int i;
local DeusExPlayer PlayerOwner;
	PlayerOwner = DeusExPlayer(Owner);

	if (PlayerOwner != None && ScriptedPawn(Owner) == None)
	{
		
		Other.TakeDamage(HitDamage, Pawn(Owner), HitLocation, Vect(0,0,0), 'Shocked');
		Other.TakeDamage(HitDamage, Pawn(Owner), HitLocation, Vect(0,0,0), 'EMP');
		if(DeusExPlayer(Other) != None)
		{
			PlayerOwner.ClientInstantFlash(-0.4, vect(450, 190, 650));
			DeusExPlayer(Other).ConsoleCommand("feigndeath");
			DeusExPlayer(Other).ClientFlash(1,Vect(20000,20000,20000));
			DeusExPlayer(Other).IncreaseClientFlashLength(12.0); //Drag that flash out for miles!!!
		}
	}
}

defaultproperties
{
    EnemyEffective=0
    EnviroEffective=4
    Concealability=3
    ShotTime=1.50
    reloadTime=1.00
    HitDamage=20
    maxRange=1920
    AccurateRange=1280
    BaseAccuracy=0.00
    bPenetrating=True
    StunDuration=15.00
    ReloadCount=250
    PickupAmmoCount=80
    FireOffset=(X=-16.00,Y=12.00,Z=19.00),
    shakemag=0.00
    shaketime=0.00
    shakevert=0.00
    InventoryGroup=108
    ItemName="Tazer"
    bToggleSteadyFlash=False
    beltDescription="TAZER"
}
