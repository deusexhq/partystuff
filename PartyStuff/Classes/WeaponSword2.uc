//=============================================================================
// WeaponSword.
//=============================================================================
class WeaponSword2 extends DeusExWeapon;

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
	local ThrownSword S;
	DXPL=DeusExPlayer(Owner);
	If(Mode==Mode_Throw)
	{
		S=Spawn(class'ThrownSword',Pawn(Owner),,Location+vect(0,0,-2),DXPL.ViewRotation);
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

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     EnemyEffective=ENMEFF_Organic
     reloadTime=0.000000
     maxRange=64
     AccurateRange=64
     BaseAccuracy=1.000000
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     mpHitDamage=20
     mpBaseAccuracy=1.000000
     mpAccurateRange=100
     mpMaxRange=100
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     bInstantHit=True
     FireOffset=(X=-25.000000,Y=10.000000,Z=24.000000)
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.SwordFire'
     SelectSound=Sound'DeusExSounds.Weapons.SwordSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.SwordHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.SwordHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.SwordHitSoft'
     InventoryGroup=13
     ItemName="Sword"
     PlayerViewOffset=(X=25.000000,Y=-10.000000,Z=-24.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Sword'
     PickupViewMesh=LodMesh'DeusExItems.SwordPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Sword3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconSword'
     largeIcon=Texture'DeusExUI.Icons.LargeIconSword'
     largeIconWidth=130
     largeIconHeight=40
     invSlotsX=3
     Description="A rather nasty-looking sword."
     beltDescription="SWORD"
     Texture=Texture'DeusExItems.Skins.ReflectionMapTex1'
     Mesh=LodMesh'DeusExItems.SwordPickup'
     CollisionRadius=26.000000
     CollisionHeight=0.500000
     Mass=20.000000
}
