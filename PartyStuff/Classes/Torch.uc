Class Torch extends DeusExWeapon;

var bool bTorchd;

function name WeaponDamageType()
{
	return 'KnockedOut';
}


simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

// Become a pickup
// Weapons that carry their ammo with them don't vanish when dropped
function BecomePickup()
{
	Super.BecomePickup();
   if (Level.NetMode != NM_Standalone)
      if (bTossedOut)
         Lifespan = 0.0;
}

function ScopeToggle()
{
local DeusExPlayer player;
Super.BeginState();
		player = DeusExPlayer(Owner);
		if (player != None)
		{
if ( !bTorchd)
{
            LightCone = 128;
            LightEffect = LE_FireWaver;
            LightPeriod = 32;
            LightPhase = 0;
            LightRadius = 25;
            LightType = LT_Steady;
            LightBrightness = 166;
            LightHue = 1;
            LightSaturation = 0;
            bActorShadows = False;
            bCorona = False;
            bLensFlare = False;
            bSpecialLit = False;
            Hitdamage=20;
MultiSkins[5] = FireTexture'Effects.Fire.OnFire_J';
bTorchd = True;
           	}
else
{
            LightCone = 0;
            LightEffect = LE_None;
            LightPeriod = 32;
            LightPhase = 0;
           LightRadius = 100;
            LightType = LT_None;
            VolumeBrightness = 255;
            Hitdamage=0;
MultiSkins[5] = Texture'PinkMaskTex';
bTorchd = False;
}
}
}

//Revert to defaults when in state DownWeapon
state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;
            Hitdamage=0;
            MultiSkins[1] = Texture'PinkMaskTex';
MultiSkins[5] = Texture'PinkMaskTex';
bTorchd = False;
	}
}

//Destroy when thrown
function DropFrom(vector StartLocation)
{
	Destroy();
}

defaultproperties
{
    LowAmmoWaterMark=0
    GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
    NoiseLevel=0.05
    reloadTime=0.00
    HitDamage=0
    maxRange=96
    AccurateRange=96
    BaseAccuracy=1.00
    AreaOfEffect=1
    bPenetrating=False
    bHasMuzzleFlash=False
    bHandToHand=True
    mpBaseAccuracy=1.00
    mpAccurateRange=96
    mpMaxRange=96
    AmmoName=Class'DeusEx.AmmoNone'
    ReloadCount=0
    bInstantHit=True
    FireOffset=(X=-21.00,Y=16.00,Z=27.00),
    shakemag=20.00
    FireSound=Sound'DeusExSounds.Weapons.NanoSwordFire'
    Misc1Sound=Sound'DeusExSounds.Weapons.NanoSwordHitFlesh'
    Misc2Sound=Sound'DeusExSounds.Weapons.NanoSwordHitHard'
    Misc3Sound=Sound'DeusExSounds.Weapons.NanoSwordHitSoft'
    InventoryGroup=120
    ItemName="|P2Torch - Press '[' {default |P3Scope|P2 key} to toggle on/off"
    PlayerViewOffset=(X=21.00,Y=-16.00,Z=-27.00),
    PlayerViewMesh=LodMesh'DeusExItems.NanoSword'
    PickupViewMesh=LodMesh'DeusExItems.NanoSwordPickup'
    ThirdPersonMesh=LodMesh'DeusExItems.NanoSword3rd'
    LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
    Icon=Texture'DeusExUI.Icons.BeltIconDragonTooth'
    largeIcon=Texture'DeusExUI.Icons.LargeIconDragonTooth'
    largeIconWidth=205
    largeIconHeight=46
    invSlotsX=4
    Description="A laserological blade of unknown origin."
    beltDescription="Torch"
    Mesh=LodMesh'DeusExItems.NanoSwordPickup'
    MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
    MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
    MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
    MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
    MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
    CollisionRadius=32.00
    CollisionHeight=2.40
    Mass=20.00
}
