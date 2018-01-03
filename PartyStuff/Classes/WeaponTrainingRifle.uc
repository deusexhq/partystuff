//=============================================================================
// WeaponAssaultGun.
//=============================================================================
class WeaponTrainingRifle extends WeaponRifle;

var bool bSafety;

function string GetDisplayString(Actor P)
{
	if(P.isA('DeusExPlayer'))
		return DeusExPlayer(p).PlayerReplicationInfo.PlayerName;
	else if(P.isA('ScriptedPawn'))
		return ScriptedPawn(P).FamiliarName;
	else if(P.isA('DeusExDecoration'))
		return DeusExDecoration(P).ItemName;
}

function GiveTo( pawn Other )
{
    super.Giveto(Other);
	bSafety=True;
	Other.ClientMessage("Training Weapon: Laser Toggle to turn safety off.");
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

function string CalcHitLoc(int HitPart)
{
	if(HitPart == 1)
		return "Head";

	if(HitPart == 2)
		return "Torso";
		
	if(HitPart == 3)
		return "Legs";

	if(HitPart == 4)
		return "Legs";
	
	if(HitPart == 5)
		return "Torso";

	if(HitPart == 6)
		return "Torso";
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	local Pawn P;
	local PSSing PSF;

		if(!bSafety)
		{
			super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
		}
		
	if( Other.isA('PlayerPawn') )
	{
		if ( CalcHitLoc(DeusExPlayer(Other).GetMPHitLocation(HitLocation)) == "Head" ) 
		{
			Broadcastmessage(DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName$" got a headshot!");			
		}
		DeusExPlayer(Owner).ClientMessage(GetDisplayString(Other)$" hit: "$CalcHitLoc(DeusExPlayer(Other).GetMPHitLocation(HitLocation)));
		
	}
	
	if(Other.isA('LAM') || Other.isA('TrainingLAM'))
	{
			super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
			Broadcastmessage(DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName$" hit a training LAM!");
			DeusExPlayer(Owner).PlayerReplicationInfo.Score += 1;
	}
}

simulated function lasertoggle()
{
	bSafety = !bSafety;
	DeusExPlayer(Owner).ClientMessage("Player Safety:"@bSafety);
}

defaultproperties
{
     bHasSilencer=True
     InventoryGroup=148
     ItemName="Training Sniper Rifle"
     beltDescription="T-RIFLE"
}
