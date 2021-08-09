//=============================================================================
// WeaponTazer.
//=============================================================================
class WeaponJTazer expands WeaponProd;

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
     ShotTime=1.500000
     reloadTime=1.000000
     HitDamage=20
     maxRange=1920
     AccurateRange=1280
     BaseAccuracy=0.000000
     bPenetrating=True
     StunDuration=15.000000
     ReloadCount=250
     PickupAmmoCount=80
     FireOffset=(X=-16.000000)
     shakemag=0.000000
     shaketime=0.000000
     shakevert=0.000000
     InventoryGroup=108
     ItemName="Tazer"
     bToggleSteadyFlash=False
     beltDescription="TAZER"
}
