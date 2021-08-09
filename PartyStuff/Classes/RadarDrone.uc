class RadarDrone extends DXRobot;

var float explosionradius;
var() float hoverdistance; //how close to get to the player.
var DeusExPlayer myOwner;
var(Sounds) sound BeepActive, BeepPassive;
var bool bDoneDanger, bDoneWorry;
var string DangerString, WorryString;
var bool bSilence;
var ToolRadarD LinkedTool;
var int pOrders;
var int RocketsRemain, rrocketsremain;
var float DroneRange;
var class<inventory> storedinv, rstoredinv;
var string iv;

replication
{
reliable if (Role==ROLE_Authority)
rRocketsRemain, rstoredinv, iv;
}

function SilentAdd(class<inventory> addClass, DeusExPlayer addTarget)
{ 
	local Inventory anItem;
	
	anItem = Spawn(addClass,,,addTarget.Location); 
	anItem.SpawnCopy(addTarget);
	anItem.Destroy();
	/*anItem.Instigator = addTarget; 
	anItem.GotoState('Idle2'); 
	anItem.bHeldItem = true; 
	anItem.bTossedOut = false; 
	
	if(Weapon(anItem) != None) 
		Weapon(anItem).GiveAmmo(addTarget); 
	anItem.GiveTo(addTarget);*/
}

function Frob(Actor Frobber, Inventory frobWith) 
{
local ToolRadarD TRD;
local inventory ga,inv;
	if(myOwner != None && myOwner == DeusExPlayer(Frobber))
	{
		if(storedinv != None)
		{
				SilentAdd(storedInv, DeusExPlayer(Frobber));
				Storedinv = None;		
				rstoredinv = Storedinv;
				iv = "NONE";
			return;
				
		}
		if(myOwner.Inhand != None && storedinv == None)
		{
			storedinv = myOwner.inhand.Class;
			rstoredinv = myOwner.inhand.Class;
			IV = myOwner.inhand.itemname;
			myOwner.inhand.Destroy();
			return;
		}
		myOwner = None;
		GotoState('Waiting');
		ExtSay("Drone released.");
		DeusExPlayer(Frobber).ClientMessage("Radar off.");
		foreach Allactors(class'toolradard',trd)
			if(trd.LinkedDrone == Self)
				trd.LinkedDrone = None;
		return;
	}
	
	if(myOwner == None)
	{
		myOwner = DeusExPlayer(Frobber);
		GotoState('following');
		ExtSay("Now following "$myOwner.PlayerReplicationinfo.PlayerName$".");
		foreach Allactors(class'toolradard',trd)
			if(trd.Owner == Frobber)
			{
				trd.LinkedDrone = Self;
				return;
			}
			
			if(storedinv == none)
				iv="none";		
		SilentAdd(class'toolRadarD', myOwner);
		SetTimer(1,False);
		return;
	}
}

function Timer()
{
	local int range;
	local DeusExPlayer player;
	local ShockRing SE;
	
		range=0;
		foreach RadiusActors(class'DeusExPlayer', player, 350, Location)
		{
			if (player != None && player != myOwner)
				range=2;		
		}
		
		foreach RadiusActors(class'DeusExPlayer', player, 1000, Location)
		{
			if (player != None && player != myOwner && range != 2)
				range=1;		
		}
		
		
	if(myOwner != None && Range==0)
	{
		SetTimer(1,False);
			if(bDoneDanger || bDoneWorry)
			{
			myOwner.PlaySound(Sound'DeusExSounds.Robot.SecurityBot3TargetLost', SLOT_Talk,2,,1024,);
				bDoneDanger=False;
				bDoneWorry=False;
				myOwner.ClientMessage("RADAR Drone: Sorry, "$myOwner.PlayerReplicationinfo.PlayerName$", I guess it was nothing.", 'TeamSay');				
			}
	}
	if(myOwner != None && Range==2)
	{
		if(!bDoneDanger)
		{
		myOwner.PlaySound(Sound'DeusExSounds.Robot.SecurityBot3TargetAcquired', SLOT_Talk,2,,1024,);
			myOwner.ClientMessage("RADAR Drone: Hey, "$myOwner.PlayerReplicationinfo.PlayerName$", there's someone very close by!", 'TeamSay');
		}
		bDoneDanger=True;
			if(!bSilence)
			{
				PlaySound(BeepActive, SLOT_None,200,, 255);
				SE = Spawn(class'ShockRing',,, Location);
				SE.Lifespan = 0.5;		
			}
		SetTimer(0.5,False);
	}
	if(myOwner != None && Range==1)
	{
		if(!bDoneworry)
		{
		myOwner.PlaySound(Sound'DeusExSounds.Robot.SecurityBot3TargetAcquired', SLOT_Talk,2,,1024,);
			myOwner.ClientMessage("RADAR Drone: Wait, "$myOwner.PlayerReplicationinfo.PlayerName$", did you hear something?", 'TeamSay');
		}
		bDoneWorry=True;
			if(!bSilence)
			{
				PlaySound(BeepActive, SLOT_None,200,, 255);
				SE = Spawn(class'ShockRing',,, Location);
				SE.Lifespan = 1;		
			}
		SetTimer(1.3,False);
	}
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
		if(myOwner != None)
		{
			AreWeTooFar = Abs(VSize(myOwner.Location - Location));
			if(AreWeTooFar > 650)
			{
					foreach AllActors(class'Inventory', Inv)
					{
						if (Inv.Owner == myOwner)
						{
								if (Inv.IsA('ToolRadarD')) 
								{
									ToolRadarD(Inv).Recreation();
									return;
								}
						}
					}
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
				MoveTarget = FindPathToward(myOwner);
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

function ExplodeNuke()
{
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 1000;
	explosionRadius = 1500;

	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionLarge',,, Location + 2*VRand()*CollisionRadius);

	Destroy();
	PlayDyingSound();
	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
}

simulated function DFX()
{
	local SphereEffect sphere;
	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
	{
	sphere.RemoteRole = ROLE_None;
	sphere.size = explosionradius / 32.0;
	Sphere.MultiSkins[0]=Texture'DeusExDeco.Skins.AlarmLightTex3';
	}
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
     BeepActive=Sound'DeusExSounds.Generic.TurretSwitch'
     RocketsRemain=30
     rrocketsremain=30
     EMPHitPoints=40
     Saymsg="I have no owner right now, grab a radar controller and let's hunt some n00bs!"
     MinHealth=20.000000
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
     FamiliarName="RADAR Drone"
     UnfamiliarName="RADAR Drone"
}
