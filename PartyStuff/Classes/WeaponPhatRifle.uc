//=============================================================================
// WeaponAssaultGun.
//=============================================================================
class WeaponPhatRifle extends DeusExWeapon;

var float	mpRecoilStrength;
var bool bReverse;

function string GetDisplayString(Actor P)
{
	if(P.isA('DeusExPlayer'))
		return DeusExPlayer(p).PlayerReplicationInfo.PlayerName;
	else if(P.isA('ScriptedPawn'))
		return ScriptedPawn(P).FamiliarName;
	else if(P.isA('DeusExDecoration'))
		return DeusExDecoration(P).ItemName;
}


simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	local Pawn P;
	local PSSing PSF;
	
	if( Other.isA('DeusExDecoration') || Other.isA('Pawn') )
	{
		if(!bReverse)
		{
			Other.Fatness += 5;
				if(Other.Fatness >= 249)
				{
					if(DeusExPlayer(Owner).bAdmin)
						DeusExPlayer(Other).ReducedDamageType = '';
					ScriptedPawn(Other).bInvincible=False;
					DeusExDecoration(Other).bInvincible=False;
					Other.TakeDamage(200,DeusExPlayer(Owner),vect(0,0,0),vect(0,0,1),'Exploded');
					Other.Fatness=Other.Default.Fatness;
				}
		}
		else
		{
			Other.Fatness -= 5;
				if(Other.Fatness <= 90)
				{
					if(DeusExPlayer(Owner).bAdmin)
						DeusExPlayer(Other).ReducedDamageType = '';
					ScriptedPawn(Other).bInvincible=False;
					DeusExDecoration(Other).bInvincible=False;
					Other.TakeDamage(200,DeusExPlayer(Owner),vect(0,0,0),vect(0,0,1),'Exploded');
					Other.Fatness=Other.Default.Fatness;
				}
		}
		return;
	}

super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
}

simulated function CycleAmmo()
{
	bReverse = !bReverse;
	DeusExPlayer(Owner).ClientMessage("Reversing:"@bReverse);
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		HitDamage = mpHitDamage;
		BaseAccuracy = mpBaseAccuracy;
		ReloadTime = mpReloadTime;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
		ReloadCount = mpReloadCount;

		// Tuned for advanced -> master skill system (Monte & Ricardo's number) client-side
		recoilStrength = 0.75;
	}
}

defaultproperties
{
     LowAmmoWaterMark=30
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     bAutomatic=True
     ShotTime=0.100000
     reloadTime=3.000000
     HitDamage=0
     BaseAccuracy=0.700000
     bCanHaveLaser=True
     bCanHaveSilencer=True
     recoilStrength=0.500000
     MinWeaponAcc=0.200000
     mpReloadTime=0.500000
     mpBaseAccuracy=1.000000
     mpAccurateRange=2400
     mpMaxRange=2400
     mpReloadCount=30
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     AmmoName=Class'DeusEx.Ammo762mm'
     ReloadCount=30
     PickupAmmoCount=30
     bInstantHit=True
     FireOffset=(X=-16.000000,Y=5.000000,Z=11.500000)
     shakemag=200.000000
     FireSound=Sound'DeusExSounds.Weapons.AssaultGunFire'
     AltFireSound=Sound'DeusExSounds.Weapons.AssaultGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultGunSelect'
     InventoryGroup=4
     ItemName="phat rifel ermergerd"
     PlayerViewOffset=(X=16.000000,Y=-5.000000,Z=-11.500000)
     PlayerViewMesh=LodMesh'DeusExItems.AssaultGun'
     PickupViewMesh=LodMesh'DeusExItems.AssaultGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.AssaultGun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconAssaultGun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAssaultGun'
     largeIconWidth=94
     largeIconHeight=65
     invSlotsX=2
     invSlotsY=2
     Description="The 7.62x51mm assault rifle is designed for close-quarters combat, utilizing a shortened barrel and 'bullpup' design for increased maneuverability. An additional underhand 20mm HE launcher increases the rifle's effectiveness against a variety of targets."
     beltDescription="PHAT"
     Mesh=LodMesh'DeusExItems.AssaultGunPickup'
     Fatness=255
     CollisionRadius=15.000000
     CollisionHeight=1.100000
     Mass=30.000000
}
