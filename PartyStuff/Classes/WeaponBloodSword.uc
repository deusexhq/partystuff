//=============================================================================
// WeaponPure
//=============================================================================
class WeaponBloodSword extends DeusExWeapon;

var int Blood, rBlood;

replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
rBlood;
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

simulated function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	local int Bloodinc;
	dxplayer = deusexplayer(other);

	if(Other.isa('Pawn') || Other.IsA('DeusExCarcass'))
	{
		if(DeusExPlayer(Owner).Health < 100)
		{
		DeusExPlayer(Owner).HealPlayer(HitDamage, True);
		}
		Bloodinc += RandRange(5,15);
	}
	
	super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
	
	Blood += Bloodinc;
	rBlood = Blood;
}

function ScopeToggle()
{
	if(Blood >= 10)
	{
		Blood -= 10;
		rBlood = Blood;
		Spawn(class'Ultima',Pawn(Owner),,Pawn(Owner).Location,Pawn(Owner).ViewRotation);
	}
}

function LaserToggle()
{
	if(Blood >= 200)
	{
		Blood -= 200;
		rBlood = Blood;
		Spawn(class'Ultima2',Pawn(Owner),,Pawn(Owner).Location,Pawn(Owner).ViewRotation);
	}
}

function CycleAmmo()
{
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
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

simulated function RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local Pawn CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;

	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);	
		StartTrace = ComputeProjectileStart(X, Y, Z);
		AdjustedAim = P.AdjustAim(1000000, StartTrace, 2*AimError, False, False);
		EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;	
		EndTrace += (FMax(1024.0, MaxRange) * Vector(AdjustedAim));
				bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				Canvas.DrawColor.R = Rand(128);
				Canvas.DrawColor.G = 0;
				Canvas.DrawColor.B = 0;
				Canvas.Font = Canvas.SmallFont;

					Canvas.DrawText("        Blood: "$rBlood);
			}
			else
				bOwnsCrossHair = False; // Only for compatibility with HDX50		
}

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     reloadTime=0.000000
     HitDamage=500
     maxRange=96
     AccurateRange=96
     BaseAccuracy=1.000000
     AreaOfEffect=AOE_Cone
     bHasMuzzleFlash=False
     bHandToHand=True
     SwingOffset=(X=24.000000,Z=2.000000)
     mpHitDamage=500
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
     ItemName="Blood Sword"
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
     Description="Eviiiil."
     beltDescription="BLOOD"
     Physics=PHYS_Rotating
     Rotation=(Pitch=900,Yaw=900,Roll=900)
     Mesh=LodMesh'DeusExItems.NanoSwordPickup'
     MultiSkins(1)=FireTexture'Effects.Laser.LaserSpot1'
     MultiSkins(4)=FireTexture'Effects.liquid.Virus_SFX'
     MultiSkins(5)=FireTexture'Effects.liquid.Virus_SFX'
     MultiSkins(6)=FireTexture'Effects.Laser.LaserSpot1'
     CollisionRadius=32.000000
     CollisionHeight=2.400000
     LightType=LT_SubtlePulse
     LightEffect=LE_Interference
     LightBrightness=224
     LightRadius=10
     Mass=20.000000
     RotationRate=(Pitch=900,Yaw=900,Roll=900)
}
