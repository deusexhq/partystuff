//=============================================================================
// WeaponNanoSword.
//=============================================================================
class WeaponNanoSword2 extends DeusExWeapon;

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
	local ThrownnanoSword S;
	DXPL=DeusExPlayer(Owner);
	If(Mode==Mode_Throw)
	{
		S=Spawn(class'ThrownnanoSword',Pawn(Owner),,Location+vect(0,0,-2),DXPL.ViewRotation);
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

state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;
	}
}

state Idle
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_Steady;
	}
}

auto state Pickup
{
	function EndState()
	{
		Super.EndState();
		LightType = LT_None;
	}
}

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     reloadTime=0.000000
     HitDamage=20
     maxRange=96
     AccurateRange=96
     BaseAccuracy=1.000000
     AreaOfEffect=AOE_Cone
     bHasMuzzleFlash=False
     bHandToHand=True
     mpHitDamage=10
     mpBaseAccuracy=1.000000
     mpAccurateRange=150
     mpMaxRange=150
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     bInstantHit=True
     FireOffset=(X=-21.000000,Y=16.000000,Z=27.000000)
     shakemag=20.000000
     FireSound=Sound'DeusExSounds.Weapons.NanoSwordFire'
     SelectSound=Sound'DeusExSounds.Weapons.NanoSwordSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.NanoSwordHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.NanoSwordHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.NanoSwordHitSoft'
     InventoryGroup=14
     ItemName="Dragon's Tooth Sword"
     ItemArticle="the"
     PlayerViewOffset=(X=21.000000,Y=-16.000000,Z=-27.000000)
     PlayerViewMesh=LodMesh'DeusExItems.NanoSword'
     PickupViewMesh=LodMesh'DeusExItems.NanoSwordPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.NanoSword3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconDragonTooth'
     largeIcon=Texture'DeusExUI.Icons.LargeIconDragonTooth'
     largeIconWidth=205
     largeIconHeight=46
     invSlotsX=4
     Description="The true weapon of a modern warrior, the Dragon's Tooth is not a sword in the traditional sense, but a nanotechnologically constructed blade that is dynamically 'forged' on command into a non-eutactic solid. Nanoscale whetting devices insure that the blade is both unbreakable and lethally sharp."
     beltDescription="DRAGON"
     Mesh=LodMesh'DeusExItems.NanoSwordPickup'
     CollisionRadius=32.000000
     CollisionHeight=2.400000
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=224
     LightHue=160
     LightSaturation=64
     LightRadius=4
     Mass=20.000000
}
