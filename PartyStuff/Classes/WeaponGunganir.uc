//=============================================================================
// WeaponRifle.
//=============================================================================
class WeaponGunganir extends DeusExWeapon;

var float	mpNoScopeMult;
var float ZoomScale,ZoomInc,
          MaxScale,MinScale;
var bool bSilenced;
var() float Thick;
var() float PawnThick;

replication
{
unreliable if(Role==ROLE_Authority)
	ZoomIn,ZoomOut;
reliable if(Role==ROLE_Authority)
	ZoomOff,ZoomScale,  bSilenced;
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
	bSilenced=False;
	}
	else
	{
	DeusExPlayer(Owner).ClientMessage("Silencer on");
	bHasSilencer = True;
	BaseAccuracy=0.000001;
	HitDamage = 100;
	bSilenced=True;
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
      bHasMuzzleFlash = True;
      ReloadCount = 3;
      ReloadTime = ShotTime;
	}
}

simulated event RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local Actor CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
		local vector loc, line;
		local string str;
		
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
		/*GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);	
		StartTrace = ComputeProjectileStart(X, Y, Z);
		AdjustedAim = P.AdjustAim(1000000, StartTrace, 2*AimError, False, False);
		EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;	
		EndTrace += (FMax(1024.0, MaxRange) * Vector(AdjustedAim));*/
				loc = P.Location;
				loc.Z += P.BaseEyeHeight;
				line = Vector(P.ViewRotation) * 90000;
			
				Trace(hitLocation, hitNormal, loc+line, loc, true);
		/*foreach P.TraceActors(class'Actor', CrosshairTarget, HitLocation, HitNormal, EndTrace, StartTrace)
		{*/
			Dist = Abs(VSize(HitLocation - P.Location));

			//if ( Dist < MaxRange )
			//{
				bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				//Canvas.Style = ERenderStyle.STY_Translucent;
				Canvas.DrawColor.R = 255;
				Canvas.DrawColor.G = 250;
				Canvas.DrawColor.B = 255;
				Canvas.Font = Canvas.SmallFont;
				//Canvas.DrawIcon(Texture'DeusExUI.UserInterface.AugIcontarget_Small', Scale);
				//Canvas.bCenter=True;
				if(bSilenced)
					str = " - Silenced";
				Canvas.DrawText("       ["$Left(ZoomScale, Len(ZoomScale)-5)$"] Distance: "$Left(Dist, Len(Dist)-7)$str);
				//Canvas.DrawPortal(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale , 30, 30, CrosshairTarget, CrosshairTarget.Location, CrosshairTarget.Rotation);
			}
			else
				bOwnsCrossHair = False; // Only for compatibility with HDX50		
		//}	
//}		
}

function Fire(float value)
{
     Local Vector offset,x,y,z;
     local rotator rot;
     if (owner==none)
        return;
     else if (!bHasMuzzleFlash)
         {
         super.fire(value);
         return;
         }
     GetAxes(pawn(owner).ViewRotation,x,y,z);
     if (owner.IsA('DeusExPlayer'))
        {
        offset = Owner.Location + CalcDrawOffset() + FireOffset.X * X + FireOffset.Y * Y + FireOffset.Z * Z;
        rot=DeusExPlayer(owner).viewRotation;
        }
     else
         {
         offset= Owner.Location;
         offset += X * Owner.CollisionRadius*2;
         rot=owner.rotation;
         }
     Flash = spawn(class'muzzleflash',,,offset,rot);
     if(flash!=none)
         {
         Flash.setbase(owner);
         //Flash.playanim('shoot');
         }
     super.fire(value);
}

function TraceFire (float Accuracy)
{
	local Vector HitLocation;
	local Vector HitNormal;
	local Vector StartTrace;
	local Vector EndTrace;
	local Vector X;
	local Vector Y;
	local Vector Z;
	local Actor Other;
	local Pawn PawnOwner;
	local float Penetration;
	local Rotator rot;
	
	PawnOwner=Pawn(Owner);
	Owner.MakeNoise(PawnOwner.SoundDampening);
	GetAxes(PawnOwner.ViewRotation,X,Y,Z);
	StartTrace=Owner.Location + CalcDrawOffset() + FireOffset.X * X + FireOffset.Y * Y + FireOffset.Z * Z;
	AdjustedAim=PawnOwner.AdjustAim(1000000.00,StartTrace,2 * aimerror,False,False);
	EndTrace=StartTrace + Accuracy * (FRand() - 0.50) * Y * 1000 + Accuracy * (FRand() - 0.50) * Z * 1000;
	X=vector(AdjustedAim);
	EndTrace += 10000 * X;
	Other=PawnOwner.TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
	rot = Rotator(EndTrace - StartTrace);
	Spawn(class'Tracer',,, StartTrace + 96 * Vector(rot), rot);
	ProcessTraceHit(Other,HitLocation,HitNormal,X,Y,Z);
	if ( Other.IsA('Pawn') )
	{
		Penetration=PawnThick;
	}
	else
	{
		Penetration=Thick;
	}
	StartTrace=HitLocation + HitNormal + Penetration * X;
	EndTrace=StartTrace + Accuracy * (FRand() - 0.50) * Y * 1000 + Accuracy * (FRand() - 0.50) * Z * 1000;
	EndTrace += 10000 * X;
	Other=PawnOwner.TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
	ProcessTraceHit(Other,HitLocation,HitNormal,X,Y,Z);
}


defaultproperties
{
	     Thick=64.000000
     PawnThick=32.000000
	    ZoomScale=1.00
    ZoomInc=0.10
    MaxScale=1.00
    MinScale=0.10
     mpNoScopeMult=0.350000
     LowAmmoWaterMark=6
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     NoiseLevel=2.000000
     EnviroEffective=ENVEFF_Air
     ShotTime=2.500000
     reloadTime=5.000000
     HitDamage=100
     maxRange=48000
     AccurateRange=28800
     bCanHaveScope=True
     bHasScope=True
     bCanHaveLaser=True
     bCanHaveSilencer=True
     bHasMuzzleFlash=False
     recoilStrength=0.400000
     bUseWhileCrouched=False
     mpReloadTime=5.000000
     mpHitDamage=100
     mpAccurateRange=28800
     mpMaxRange=28800
     mpReloadCount=3
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     AmmoName=Class'DeusEx.Ammo3006'
     ReloadCount=6
     PickupAmmoCount=6
     bInstantHit=True
     FireOffset=(X=-20.000000,Y=2.000000,Z=30.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.RifleFire'
     AltFireSound=Sound'DeusExSounds.Weapons.RifleReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.RifleReload'
     SelectSound=Sound'DeusExSounds.Weapons.RifleSelect'
     InventoryGroup=5
     ItemName="Gunganir HAG35"
	 ItemArticle="the"
     PlayerViewOffset=(X=20.000000,Y=-2.000000,Z=-30.000000)
     PlayerViewMesh=LodMesh'DeusExItems.SniperRifle'
     PickupViewMesh=LodMesh'DeusExItems.SniperRiflePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.SniperRifle3rd'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconRifle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconRifle'
     largeIconWidth=159
     largeIconHeight=47
     invSlotsX=4
     Description="The military sniper rifle is the superior tool for the interdiction of long-range targets. When coupled with the proven 30.06 round, a marksman can achieve tight groupings at better than 1 MOA (minute of angle) depending on environmental conditions."
     beltDescription="HAG35"
     Mesh=LodMesh'DeusExItems.SniperRiflePickup'
     CollisionRadius=26.000000
     CollisionHeight=2.000000
     Mass=30.000000
}
