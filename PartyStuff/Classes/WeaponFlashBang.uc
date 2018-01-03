//=============================================================================
// WeaponFlashBang.
//=============================================================================
class WeaponFlashBang expands WeaponEMPGrenade;

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
   return ((BeltSpot <= 9) && (BeltSpot >= 1));
}

defaultproperties
{
    AmmoName=Class'AmmoFlashBang'
    PickupAmmoCount=2
    ProjectileClass=Class'FlashBang'
    InventoryGroup=118
    ItemName="Flash Bang Grenade"
    ItemArticle="a"
    beltDescription="Flash"
    MultiSkins(4)=FireTexture'Effects.UserInterface.WhiteStatic'
    MultiSkins(5)=FireTexture'Effects.UserInterface.WhiteStatic'
    MultiSkins(6)=FireTexture'Effects.UserInterface.WhiteStatic'
    MultiSkins(7)=FireTexture'Effects.UserInterface.WhiteStatic'
}
