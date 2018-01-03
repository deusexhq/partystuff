class WeaponMagnum extends WeaponPistol;

var float	mpRecoilStrength;
var MuzzleFlash flash;
var float mpNoScopeMult;
var() float Thick;
var() float PawnThick;

//simulated function bool clientFire(float value)
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

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     Thick=64.000000
     PawnThick=32.000000
     HitDamage=45
     bHasScope=True
     mpHitDamage=100
     FireSound=Sound'DeusExSounds.Weapons.RifleFire'
     AltFireSound=Sound'DeusExSounds.Weapons.RifleReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.RifleReload'
     SelectSound=Sound'DeusExSounds.Weapons.RifleSelect'
     InventoryGroup=122
     ItemName="Magnum"
     ItemArticle="the"
     beltDescription="MGNM"
     Mass=1.000000
}
