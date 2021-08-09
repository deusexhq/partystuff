//=============================================================================
// WeaponFlashBang.
//=============================================================================
class WeaponLightshow expands WeaponEMPGrenade;

function PostBeginPlay()
{
   Super.PostBeginPlay();
   bWeaponStay=False;
}

function Fire(float Value)
{
	if (Pawn(Owner) != None)
	{
		if (bNearWall)
		{
			bReadyToFire = False;
			GotoState('NormalFire');
			bPointing = True;
			PlayAnim('Place',, 0.1);
			return;
		}
	}
	Super.Fire(Value);
}

function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Projectile proj;

	proj = Super.ProjectileFire(ProjClass, ProjSpeed, bWarn);

	if (proj != None)
		proj.PlayAnim('Open');
}

function BecomePickup()
{
	Super.BecomePickup();
   if (Level.NetMode != NM_Standalone)
      if (bTossedOut)
         Lifespan = 0.0;
}
simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 4);
}

defaultproperties
{
     AmmoName=Class'PartyStuff.AmmoLS'
     ProjectileClass=Class'PartyStuff.Lightshow'
     InventoryGroup=35
     ItemName="Lightshow"
     ItemArticle="a"
     Description="A Lighter.."
     beltDescription="LIGHT"
     MultiSkins(4)=Texture'DeusExDeco.Skins.AlarmLightTex3'
}
