//=============================================================================
// WeaponCrowbar.
//=============================================================================
class WeaponCrowbar2 extends DeusExWeapon;

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
	local ThrownCrowbar S;
	DXPL=DeusExPlayer(Owner);
	If(Mode==Mode_Throw)
	{
		S=Spawn(class'ThrownCrowbar',Pawn(Owner),,Location+vect(0,0,-2),DXPL.ViewRotation);
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
     reloadTime=0.000000
     HitDamage=6
     maxRange=80
     AccurateRange=80
     BaseAccuracy=1.000000
     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False
     mpHitDamage=12
     mpBaseAccuracy=1.000000
     mpAccurateRange=96
     mpMaxRange=96
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     bInstantHit=True
     FireOffset=(X=-40.000000,Y=15.000000,Z=8.000000)
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.CrowbarFire'
     SelectSound=Sound'DeusExSounds.Weapons.CrowbarSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.CrowbarHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.CrowbarHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.CrowbarHitSoft'
     InventoryGroup=10
     ItemName="Crowbar"
     PlayerViewOffset=(X=40.000000,Y=-15.000000,Z=-8.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Crowbar'
     PickupViewMesh=LodMesh'DeusExItems.CrowbarPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Crowbar3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconCrowbar'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCrowbar'
     largeIconWidth=101
     largeIconHeight=43
     invSlotsX=2
     Description="A crowbar. Hit someone or something with it. Repeat.|n|n<UNATCO OPS FILE NOTE GH010-BLUE> Many crowbars we call 'murder of crowbars.'  Always have one for kombat. Ha. -- Gunther Hermann <END NOTE>"
     beltDescription="CROWBAR"
     Mesh=LodMesh'DeusExItems.CrowbarPickup'
     CollisionRadius=19.000000
     CollisionHeight=1.050000
     Mass=15.000000
}
