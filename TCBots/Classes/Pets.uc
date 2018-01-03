class Pets extends Animal;

var DeusExPlayer myOwner;
var int Hunger, Mood;
var bool bHasNickname;

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

   if (DeusExPlayer(Frobber) == None)
      return;

	if(myOwner == None)
	{
		myOwner=DeusExPlayer(Frobber);
		myOwner.ClientMessage("Now the pet's owner.");
		if(!bHasNickname)
			FamiliarName = myOwner.PlayerReplicationInfo.PlayerName$"'s pet";
		GotoState('following');
	}
	else
	{
		if(DeusExPlayer(Frobber) == myOwner)
		{
			myOwner.ClientMessage("No longer the pet's owner.");
			myOwner=None;
			if(!bHasNickname)
				FamiliarName = "Pet";
			GotoState('wandering');
		}
	}
}

function bool ShouldFlee()
{
	return false;
}

function bool FilterDamageType(Pawn instigatedBy, Vector hitLocation, Vector offset, Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Flamed') || (damageType == 'Burned'))
		return false;
	else
		return Super.FilterDamageType(instigatedBy, hitLocation, offset, damageType);
}

function bool AICanShoot(pawn target, bool bLeadTarget, bool bCheckReadiness, optional float throwAccuracy, optional bool bDiscountMinRange)
{
	return true;
}

state Following
{
	function SetFall()
	{
		StartFalling('Following', 'ContinueFollow');
	}

	function HitWall(vector HitNormal, actor Wall)
	{
		if (Physics == PHYS_Falling)
			return;
		Global.HitWall(HitNormal, Wall);
		CheckOpenDoor(HitNormal, Wall);
	}

	function Tick(float deltaSeconds)
	{
	local float AreWeTooFar;
	      local Inventory Inv;
		Global.Tick(deltaSeconds);
		if(myOwner != None)
		{
			AreWeTooFar = Abs(VSize(myOwner.Location - Location));
			if(AreWeTooFar > 750)
			{
				SetCollision(false, false, false);
				bCollideWorld = true;
				SetLocation(myOwner.location);
				SetCollision(true, true , true);
			}
		}
		
		if (BackpedalTimer >= 0)
			BackpedalTimer += deltaSeconds;

		animTimer[1] += deltaSeconds;
		if ((Physics == PHYS_Walking) && (myOwner != None))
		{
			if (Acceleration == vect(0,0,0))
				LookAtActor(myOwner, true, true, true, 0, 0.25);
			else
				PlayTurnHead(LOOK_Forward, 1.0, 0.25);
		}
	}

	function bool PickDestination()
	{
		local float   dist;
		local float   extra;
		local float   distMax;
		local int     dir;
		local rotator rot;
		local bool    bSuccess;

		if(myOwner == None)
			return False;
		bSuccess = false;
		destPoint = None;
		destLoc   = vect(0, 0, 0);
		extra = myOwner.CollisionRadius + CollisionRadius;
		dist = VSize(myOwner.Location - Location);
		dist -= extra;
		if (dist < 0)
			dist = 0;

		if ((dist > 180) || (AICanSee(myOwner, , false, false, false, true) <= 0))
		{
			if (ActorReachable(myOwner))
			{
				rot = Rotator(myOwner.Location - Location);
				distMax = (dist-180)+45;
				if (distMax > 80)
					distMax = 80;
				bSuccess = AIDirectionReachable(Location, rot.Yaw, rot.Pitch, 0, distMax, destLoc);
			}
			else
			{
				MoveTarget = FindPathToward(myOwner,true,true);
				if (MoveTarget != None)
				{
					destPoint = MoveTarget;
					bSuccess = true;
				}
			}
			BackpedalTimer = -1;
		}
		else if (dist < 60)
		{
			if (BackpedalTimer < 0)
				BackpedalTimer = 0;
			if (BackpedalTimer > 1.0)  // give the player enough time to converse, if he wants to
			{
				rot = Rotator(Location - myOwner.Location);
				bSuccess = AIDirectionReachable(myOwner.Location, rot.Yaw, rot.Pitch, 60+extra, 120+extra, destLoc);
			}
		}
		else
			BackpedalTimer = -1;

		return (bSuccess);
	}

	function BeginState()
	{
		//setphysics(PHYS_flying); //added
		StandUp();
		//Disable('AnimEnd');
		bStasis = False;
		SetupWeapon(false);
		SetDistress(false);
		BackpedalTimer = -1;
		SeekPawn = None;
		EnableCheckDestLoc(true);
	}

	function EndState()
	{
		EnableCheckDestLoc(false);
		bAcceptBump = False;
		//Enable('AnimEnd');
		bStasis = True;
		StopBlendAnims();
	}

Begin:
	Acceleration = vect(0, 0, 0);
	destPoint = None;
	if (myOwner == None)
		GotoState('Standing');

	if (!PickDestination())
		Goto('Wait');

Follow:
	if (destPoint != None)
	{
		if (MoveTarget != None)
		{
			if (ShouldPlayWalk(MoveTarget.Location))
				PlayRunning();
			MoveToward(MoveTarget, MaxDesiredSpeed);
			CheckDestLoc(MoveTarget.Location, true);
		}
		else
			Sleep(0.0);  // this shouldn't happen
	}
	else
	{
		if (ShouldPlayWalk(destLoc))
			PlayRunning();
		MoveTo(destLoc, MaxDesiredSpeed);
		CheckDestLoc(destLoc);
	}
	if (PickDestination())
		Goto('Follow');

Wait:
	//PlayTurning();
	//TurnToward(myOwner);
	PlayWaiting();

WaitLoop:
	Acceleration=vect(0,0,0);
	Sleep(0.0);
	if (!PickDestination())
		Goto('WaitLoop');
	else
		Goto('Follow');

ContinueFollow:
ContinueFromDoor:
	Acceleration=vect(0,0,0);
	if (PickDestination())
		Goto('Follow');
	else
		Goto('Wait');

}


defaultproperties
{
     Health=600
     FamiliarName="DEFAULT PET"
     UnfamiliarName="DEFAULT PET"
	AttitudeToPlayer=bATTITUDE_Follow
	bHateHacking=False
bHateWeapon=False
bHateShot=False
bHateInjury=False
bHateIndirectInjury=False
bHateCarcass=False
bHateDistress=False
bReactFutz=False
bReactPresence=False
bReactLoudNoise=False
bReactAlarm=False
bReactShot=False
bReactCarcass=False
bReactDistress=False
bReactProjectiles=False
bFearHacking=False
bFearWeapon=False
bFearShot=False
bFearInjury=False
bFearIndirectInjury=False
bFearCarcass=False
bFearDistress=False
bFearAlarm=False
bFearProjectiles=False
}
