class WeaponAirget extends DeusExWeapon;

var float	mpRecoilStrength;
var int muznum; //loop through muzzleflashes
var texture muztex; //sigh
var int airammo, rAirammo;

replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
rAirammo;
}

function Tick(float deltatime)
{
	super.Tick(deltatime);
	
	if(bZoomed)
	{
		DeusExPlayer(Owner).Energy -= 0.25;
		if(DeusExPlayer(Owner).Energy <= 0)
		{
			ScopeOff();
		}
	}
}

function LaserToggle()
{
	local vector v2;
	
	v2 = Owner.location;
	v2.z += 20;
		if(AirAmmo >= 1)
		{
			Spawn(class'Rocket',Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
			AirAmmo -= 1;
			rAirammo = AirAmmo;
		}
}

function ScopeOn()
{
   if (bHasScope && !bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
   {
      bZoomed = True;
      RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
   }
}

function ScopeOff()
{
	if (bHasScope && bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		bZoomed = False;
		RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
	}
}


simulated function RefreshScopeDisplay(DeusExPlayer player, bool bInstant, bool bScopeOn)
{
	if (bScopeOn && (Player !=None))
	{
		DeusExPlayer(Owner).PlaySound(sound'Switch2ClickOn', SLOT_Talk,2,,1024,);
		DeusExRootWindow(Player.RootWindow).HUD.AugDisplay.bVisionActive = True;
		DeusExRootWindow(Player.RootWindow).HUD.AugDisplay.VisionLevel = 3;
		DeusExRootWindow(Player.RootWindow).HUD.AugDisplay.VisionLevelValue = 28800;
	}
	else if (!bScopeOn)
	{
		DeusExPlayer(Owner).PlaySound(sound'Switch2ClickOff', SLOT_Talk,2,,1024,);
		DeusExRootWindow(Player.RootWindow).HUD.AugDisplay.bVisionActive = False;
	}
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

/*simulated function renderoverlays(Canvas canvas)
{

	super.renderoverlays(canvas);
}*/

simulated event RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local Actor CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
		local vector loc, line;
			local String KeyName, Alias, curKeyName;
	local int i;
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
		if(muztex != none && multiskins[2] != muztex) //don't overwrite the muzzleflash..this is fucking ugly, but I think we can spare some comp cycles for shit like this
		multiskins[2]=muztex;
	else 
		multiskins[2]=none;

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
				curKeyName = "";
				for ( i=0; i<255; i++ )
				{
					KeyName = Owner.ConsoleCommand ( "KEYNAME "$i );
					if ( KeyName != "" )
					{
						Alias = Owner.ConsoleCommand( "KEYBINDING "$KeyName );
						if ( Alias ~= "ToggleLaser" )
						{
							curKeyName = KeyName;
							break;
						}
					}
				}
				if ( curKeyName ~= "" )
					curKeyName = "NONE";
					
				Canvas.DrawText("      Alt Ammo: "$rAirAmmo$"/10 ["$curKeyName$"] - Distance: "$Left(Dist, Len(Dist)-7));
			}
			else
				bOwnsCrossHair = False; // Only for compatibility with HDX50		
		//}	
//}		
}

simulated function SwapMuzzleFlashTexture()
{
	Muztex = GetMuzzleTex();
	Multiskins[2] = Muztex;
	MuzzleFlashLight();
	SetTimer(0.1, False);
}

simulated function texture GetMuzzleTex()
{
	local texture tex;

	muznum++;
	if(muznum > 7)
		muznum = 0;
	switch(muznum)
	{
		case 0: tex = texture'HDTPMuzzleflashlarge1'; break;
		case 1: tex = texture'HDTPMuzzleflashlarge2'; break;
		case 2: tex = texture'HDTPMuzzleflashlarge3'; break;
		case 3: tex = texture'HDTPMuzzleflashlarge4'; break;
		case 4: tex = texture'HDTPMuzzleflashlarge5'; break;
		case 5: tex = texture'HDTPMuzzleflashlarge6'; break;
		case 6: tex = texture'HDTPMuzzleflashlarge7'; break;
		case 7: tex = texture'HDTPMuzzleflashlarge8'; break;
	}
	return tex;
}

simulated function EraseMuzzleFlashTexture()
{
	local int i;

	Muztex = none; //put this before the silencer check just in case we somehow add a silencer while mid shooting (it could happen!)
	if(!bHasMuzzleflash || bHasSilencer)
		return;

	MultiSkins[2] = None;
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     LowAmmoWaterMark=30
     AirAmmo=10
     rAirammo=10
     GoverningSkill=Class'DeusEx.SkillWeaponRifle'
     EnviroEffective=ENVEFF_Air
     Concealability=CONC_Visual
     bAutomatic=True
     ShotTime=0.100000
     reloadTime=3.000000
     HitDamage=10
     BaseAccuracy=0.000003
     bCanHaveLaser=True
     bCanHaveSilencer=True
     recoilStrength=0.500000
     MinWeaponAcc=0.000002
     mpReloadTime=0.500000
     mpHitDamage=20
     mpBaseAccuracy=0.0000002
     mpAccurateRange=2400
     mpMaxRange=2400
     mpReloadCount=20
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
	 bHasLaser=True
	 bHasScope=True
     AmmoName=Class'DeusEx.Ammo762mm'
     ReloadCount=20
     PickupAmmoCount=60
     bInstantHit=True
     FireOffset=(X=-16.000000,Y=5.000000,Z=11.500000)
     shakemag=200.000000
     FireSound=Sound'DeusExSounds.Weapons.AssaultGunFire'
     AltFireSound=Sound'DeusExSounds.Weapons.AssaultGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultGunSelect'
     InventoryGroup=45242
     ItemName="Airget-Lamh B/V2"
     PlayerViewOffset=(X=10,Y=-5,Z=-15)
     PlayerViewMesh=LodMesh'BRAssaultGun'
     PickupViewMesh=LodMesh'BRAssaultGunPickup'
     ThirdPersonMesh=LodMesh'BRAssaultGun3rd'
     Mesh=LodMesh'BRAssaultGunPickup'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'BeltIconSGAssault'
     largeIcon=Texture'LargeSGAssaultIcon'
	largeIconWidth=203
	largeIconHeight=77
     invSlotsX=2
     invSlotsY=2
     Description="The 7.62x51mm assault rifle is designed for close-quarters combat, utilizing a shortened barrel and 'bullpup' design for increased maneuverability. An additional underhand 20mm HE launcher increases the rifle's effectiveness against a variety of targets."
     beltDescription="AIRGET"
     CollisionRadius=15.000000
     CollisionHeight=1.100000
     Mass=30.000000
}
