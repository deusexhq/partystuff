class SecDrone extends DXRobot;

var float explosionradius;
var() float hoverdistance; //how close to get to the player.
var DeusExPlayer AttachPlayer;
var float DroneRange;
var DeusExPlayer NotifPlayer;

function Frob(Actor Frobber, Inventory frobWith) 
{
}

function Timer()
{
	if(NotifPlayer != None)
	{
		NotifPlayer.ClientMessage(AttachPlayer.PlayerReplicationInfo.PlayerName$" was killed by your security.");
	}
	PlaySound(Sound'DeusExSounds.Weapons.RifleFire',,,, 256);
	AttachPlayer.ReducedDamageType='';
	AttachPlayer.TakeDamage(10000,Self,vect(0,0,0),vect(0,0,1),'Exploded');
	Destroy();
}

function bool ShouldFlee()
{
	return false;
}

auto state StartUp
{
	function BeginState()
	{
		bInterruptState = true;
		bCanConverse = false;

		bStasis = False;
		SetDistress(false);
		BlockReactions();
		ResetDestLoc();
		InitializePawn();

		gotostate('following');
	}

	function EndState()
	{
		bCanConverse = true;
		bStasis = True;
		ResetReactions();
	}
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
		
		if(AttachPlayer != None)
		{
			if(AttachPlayer.bAdmin)
			{
				AttachPlayer.ClientMessage("Security Drone: Sorry, my mistake.", 'TeamSay');
				Destroy();
			}
			AreWeTooFar = Abs(VSize(AttachPlayer.Location - Location));
			if(AreWeTooFar > 650)
			{
				SetCollision(false, false, false);
				bCollideWorld = true;
				SetLocation(AttachPlayer.location);
				SetCollision(true, true , true);
			}
		}
		
		if (BackpedalTimer >= 0)
			BackpedalTimer += deltaSeconds;

		animTimer[1] += deltaSeconds;
		if ((Physics == PHYS_Walking) && (AttachPlayer != None))
		{
			if (Acceleration == vect(0,0,0))
				LookAtActor(AttachPlayer, true, true, true, 0, 0.25);
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

		if(AttachPlayer == None)
			return False;
		bSuccess = false;
		destPoint = None;
		destLoc   = vect(0, 0, 0);
		extra = AttachPlayer.CollisionRadius + CollisionRadius;
		dist = VSize(AttachPlayer.Location - Location);
		dist -= extra;
		if (dist < 0)
			dist = 0;

		if ((dist > 180) || (AICanSee(AttachPlayer, , false, false, false, true) <= 0))
		{
			if (ActorReachable(AttachPlayer))
			{
				rot = Rotator(AttachPlayer.Location - Location);
				distMax = (dist-180)+45;
				if (distMax > 80)
					distMax = 80;
				bSuccess = AIDirectionReachable(Location, rot.Yaw, rot.Pitch, 0, distMax, destLoc);
			}
			else
			{
				MoveTarget = FindPathToward(AttachPlayer);
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
				rot = Rotator(Location - AttachPlayer.Location);
				bSuccess = AIDirectionReachable(AttachPlayer.Location, rot.Yaw, rot.Pitch, 60+extra, 120+extra, destLoc);
			}
		}
		else
			BackpedalTimer = -1;

		return (bSuccess);
	}

	function BeginState()
	{
		setphysics(PHYS_flying); //added
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
	if (AttachPlayer == None)
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
	//TurnToward(AttachPlayer);
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

function PlayRunningAndFiring() {}
function TweenToShoot(float tweentime) {}
function PlayShoot() {}
function TweenToAttack(float tweentime) {}
function PlayAttack() {}
function PlaySittingDown() {}
function PlaySitting() {}
function PlayStandingUp() {}
function PlayRubbingEyesStart() {}
function PlayRubbingEyes() {}
function PlayRubbingEyesEnd() {}
function PlayStunned() {}
function PlayFalling() {}
function PlayLanded(float impactVel) {}
function PlayDuck() {}
function PlayRising() {}
function PlayCrawling() {}
function PlayPushing() {}
function PlayFiring() {}
function PlayTakingHit(EHitLocation hitPos) {}
function PlayCowerBegin() {}
function PlayCowering() {}
function PlayCowerEnd() {}
function PlayPanicRunning() {}
function PlayTurning() {}
function TweenToWalking(float tweentime) {}
function PlayWalking() {}
function TweenToRunning(float tweentime) {}
function PlayRunning() {}
function TweenToWaiting(float tweentime) {}
function PlayWaiting() {}
function TweenToSwimming(float tweentime){}
function PlaySwimming() {}
function PlayDying(name damageType, vector hitLoc) {}

defaultproperties
{
     explosionRadius=100.000000
     hoverdistance=200.000000
     EMPHitPoints=40
     MinHealth=20.000000
     bInvincible=True
     bMustFaceTarget=True
     bCanStrafe=True
     AirSpeed=1000.000000
     AccelRate=350.000000
     Health=600
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SpyDrone'
     SoundRadius=24
     SoundVolume=92
     AmbientSound=Sound'DeusExSounds.Augmentation.AugDroneLoop'
     CollisionRadius=13.000000
     CollisionHeight=2.760000
     bBlockPlayers=False
     Mass=20.000000
     BindName="Drone"
     FamiliarName="Security Drone"
     UnfamiliarName="Security Drone"
}
