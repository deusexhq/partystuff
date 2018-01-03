class WeaponZoomSniper extends DeusExWeapon;

var float ZoomScale,ZoomInc,
          MaxScale,MinScale;

replication
{
unreliable if(Role==ROLE_Authority)
	ZoomIn,ZoomOut;
reliable if(Role==ROLE_Authority)
	ZoomOff,ZoomScale;
reliable if(Role<ROLE_Authority)
	UpdateScope;
}

simulated function UpdateScope(float FOV,bool bShow)
{
bZoomed=bShow;
ScopeFOV=FOV;

RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
}

simulated exec function DisableScope()
{
ScopeOff();
}

simulated function ScopeOff()
{
ZoomOff();
UpdateScope(ScopeFOV,False);
}

simulated function ZoomOff()
{
if(bHasScope && bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
	bZoomed = False;
	ZoomScale=MaxScale;
	ScopeFOV=80*ZoomScale;
	BaseAccuracy=0.12/ZoomScale;
	UpdateScope(ScopeFOV,False);
	}
}

Function AltFire(float Value)
{
	if(bHasSilencer)
	{
	DeusExPlayer(Owner).ClientMessage("Silencer off");
	bHasSilencer = False;
	BaseAccuracy=Default.BaseAccuracy;
	HitDamage = Default.HitDamage;
	}
		else
	{
	DeusExPlayer(Owner).ClientMessage("Silencer on");
	bHasSilencer = True;
	BaseAccuracy=0.000001;
	HitDamage = 100;
	}
}

simulated function CycleAmmo()
{
	ZoomOff();
	ScopeOff();
	DisableScope();
	ZoomScale=MaxScale;
	bZoomed=False;
	UpdateScope(ScopeFOV,bZoomed);
}

simulated function LaserToggle()
{
ZoomOut();
}

simulated function ScopeToggle()
{
ZoomIn();
}

simulated function bool ZoomOut()
{
if(bZoomed)
	{
	ZoomScale+=ZoomInc;
	if(ZoomScale>MaxScale)
		{
		ZoomScale=MaxScale;
		bZoomed=False;
		}
	ScopeFOV=80*ZoomScale;
	BaseAccuracy=0.12/ZoomScale;
	UpdateScope(ScopeFOV,bZoomed);
	}

return bZoomed;
}

simulated function bool ZoomIn()
{
bZoomed=True;

ZoomScale-=ZoomInc;

if(ZoomScale<MinScale)
	ZoomScale=MinScale;
ScopeFOV=80*ZoomScale;
BaseAccuracy=0.12/ZoomScale;
UpdateScope(ScopeFOV,True);

return bZoomed;
}

defaultproperties
{
    ZoomScale=1.00
    ZoomInc=0.10
    MaxScale=1.00
    MinScale=0.10
    LowAmmoWaterMark=6
    GoverningSkill=Class'DeusEx.SkillWeaponRifle'
    NoiseLevel=2.00
    EnviroEffective=1
    ShotTime=1.50
    reloadTime=2.00
    HitDamage=25
    maxRange=48000
    AccurateRange=28800
    bCanHaveScope=True
    bHasScope=True
    ScopeFOV=80
    bCanHaveLaser=True
    bCanHaveSilencer=True
    bHasMuzzleFlash=False
    recoilStrength=0.40
    bUseWhileCrouched=False
    mpReloadTime=2.00
    mpHitDamage=25
    mpAccurateRange=28800
    mpMaxRange=28800
    mpReloadCount=6
    bCanHaveModBaseAccuracy=True
    bCanHaveModReloadCount=True
    bCanHaveModAccurateRange=True
    bCanHaveModReloadTime=True
    bCanHaveModRecoilStrength=True
    AmmoName=Class'DeusEx.Ammo3006'
    ReloadCount=6
    PickupAmmoCount=6
    bInstantHit=True
    FireOffset=(X=-20.00,Y=2.00,Z=30.00),
    shakemag=50.00
    FireSound=Sound'DeusExSounds.Weapons.RifleFire'
    AltFireSound=Sound'DeusExSounds.Weapons.RifleReloadEnd'
    CockingSound=Sound'DeusExSounds.Weapons.RifleReload'
    SelectSound=Sound'DeusExSounds.Weapons.RifleSelect'
    InventoryGroup=5
    ItemName="Sniper Rifle [+Zoomable Scope & Attached Silencer]"
    PlayerViewOffset=(X=20.00,Y=-2.00,Z=-30.00),
    PlayerViewMesh=LodMesh'DeusExItems.SniperRifle'
    PickupViewMesh=LodMesh'DeusExItems.SniperRiflePickup'
    ThirdPersonMesh=LodMesh'DeusExItems.SniperRifle3rd'
    LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
    Icon=Texture'DeusExUI.Icons.BeltIconRifle'
    largeIcon=Texture'DeusExUI.Icons.LargeIconRifle'
    largeIconWidth=159
    largeIconHeight=47
    invSlotsX=2
    Description="The military sniper rifle is the superior tool for the interdiction of long-range targets. When coupled with the proven 30.06 round, a marksman can achieve tight groupings at better than 1 MOA (minute of angle) depending on environmental conditions."
    beltDescription="(Z)SNIPER"
    Mesh=LodMesh'DeusExItems.SniperRiflePickup'
    CollisionRadius=26.00
    CollisionHeight=2.00
    Mass=30.00
}
