//=============================================================================
// WeaponBaton.
//=============================================================================
class WeaponBaton2 extends DeusExWeapon;

enum EModeNum
{
	Mode_Normal,
	Mode_Throw,
};

Var EModeNum Mode;
var DeusExPlayer DXPl;

replication
{
	Reliable if(Role==ROLE_AUTHORITY)
		Mode;
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
	}
}

Function Fire(Float value)
{
	local Thrownbaton S;
	DXPL=DeusExPlayer(Owner);
	If(Mode==Mode_Throw)
	{
		S=Spawn(class'Thrownbaton',Pawn(Owner),,Location+vect(0,0,-2),DXPL.ViewRotation);
		if(S!=None)
		{
			S.SetOwner(DXPL);
			S.Lifespan=15;
		}
		Destroy();
	}
	else
	{
		Super.Fire(Value);
	}
}

Function cycleammo()
{
	switch Mode
		{
		case MODE_Normal:
			Mode = MODE_Throw;
			if (Role == ROLE_Authority)
			Pawn(Owner).Clientmessage("Throwing mode");
			break;

		case MODE_Throw:
			Mode = MODE_Normal;
			if (Role == ROLE_Authority)
			Pawn(Owner).Clientmessage("Normal mode");
			break;
			
		}
}

function name WeaponDamageType()
{
	return 'KnockedOut';
}

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     reloadTime=0.000000
     HitDamage=7
     maxRange=80
     AccurateRange=80
     BaseAccuracy=1.000000
     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     bInstantHit=True
     FireOffset=(X=-24.000000,Y=14.000000,Z=17.000000)
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.BatonFire'
     SelectSound=Sound'DeusExSounds.Weapons.BatonSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.BatonHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.BatonHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.BatonHitSoft'
     InventoryGroup=24
     ItemName="Baton"
     PlayerViewOffset=(X=24.000000,Y=-14.000000,Z=-17.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Baton'
     PickupViewMesh=LodMesh'DeusExItems.BatonPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Baton3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconBaton'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBaton'
     largeIconWidth=46
     largeIconHeight=47
     Description="A hefty looking baton, typically used by riot police and national security forces to discourage civilian resistance."
     beltDescription="BATON"
     Mesh=LodMesh'DeusExItems.BatonPickup'
     CollisionRadius=14.000000
     CollisionHeight=1.000000
}
