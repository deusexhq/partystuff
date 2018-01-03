class DroneChopper extends DXRobot;

var float explosionradius;
var() float hoverdistance; //how close to get to the player.

function usesuicide()
{
	local Inventory    inv;
	local int i;

	inv             = Inventory;
	while (inv != none)
	{
		inv.destroy();
		inv = inv.inventory;
	}

	inventory = spawn(Class'weaponhoverbotsuicide', self);

	SetWeapon(weapon(inventory));
}

function bool ShouldFlee()
{
	if (Health <= MinHealth)
		usesuicide();
	else if (HealthArmLeft <= 0)
		usesuicide();
	else if (HealthArmRight <= 0)
		usesuicide();
	else if (HealthLegLeft <= 0)
		usesuicide();
	else if (HealthLegRight <= 0)
		usesuicide();

	return false;
}

state wandering
{
	function beginstate()
	{
		gotostate('hanging');
	}
}

function BigExplode(vector HitLocation)
{
	local int i, num;
	local Vector loc;
	local DeusExFragment s;
	local ExplosionLight light;

//	explosionRadius = (CollisionRadius + CollisionHeight) / 2;
	PlaySound(explosionSound, SLOT_None, 2.0,, explosionRadius*32);

	if (explosionRadius < 48.0)
		PlaySound(sound'LargeExplosion1', SLOT_None,,, explosionRadius*32);
	else
		PlaySound(sound'LargeExplosion2', SLOT_None,,, explosionRadius*32);

	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, HitLocation);
	for (i=0; i<explosionRadius/20+1; i++)
	{
		loc = Location + VRand() * CollisionRadius;
		if (explosionRadius < 16)
		{
			Spawn(class'ExplosionSmall',,, loc);
			light.size = 2;
		}
		else if (explosionRadius < 32)
		{
			Spawn(class'ExplosionMedium',,, loc);
			light.size = 4;
		}
		else
		{
			Spawn(class'ExplosionLarge',,, loc);
			light.size = 8;
		}
	}

	// spawn some metal fragments
	num = FMax(3, (collisionheight + collisionradius) * 0.5/6);
	for (i=0; i<num; i++)
	{
		s = Spawn(class'MetalFragment', Owner);
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity, (collisionheight + collisionradius) * 0.5);
			s.DrawScale = (collisionheight + collisionradius) * 0.5 *0.075*FRand();
			s.Skin = GetMeshTexture();
			if (FRand() < 0.75)
				s.bSmoking = True;
		}
	}

	// cause the damage
	HurtRadius(explosionRadius, 8*explosionRadius, 'Exploded', 100*explosionRadius, Location); //removed 0.5* from first parameter

destroy();
}

function SmallExplode(vector HitLocation)
{
	local int i, num;
	local Vector loc;
	local DeusExFragment s;
	local ExplosionLight light;

	explosionRadius = explosionradius / 5;
	PlaySound(explosionSound, SLOT_None, 2.0,, explosionRadius*32);

	if (explosionRadius < 48.0)
		PlaySound(sound'LargeExplosion1', SLOT_None,,, explosionRadius*32);
	else
		PlaySound(sound'LargeExplosion2', SLOT_None,,, explosionRadius*32);

	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, HitLocation);
	for (i=0; i<explosionRadius/20+1; i++)
	{
		loc = Location + VRand() * CollisionRadius;
		if (explosionRadius < 16)
		{
			Spawn(class'ExplosionSmall',,, loc);
			light.size = 2;
		}
		else if (explosionRadius < 32)
		{
			Spawn(class'ExplosionMedium',,, loc);
			light.size = 4;
		}
		else
		{
			Spawn(class'ExplosionLarge',,, loc);
			light.size = 8;
		}
	}

	// spawn some metal fragments
	num = FMax(3, (collisionheight + collisionradius) * 0.5/6);
	for (i=0; i<num; i++)
	{
		s = Spawn(class'MetalFragment', Owner);
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity, (collisionheight + collisionradius) * 0.5);
			s.DrawScale = (collisionheight + collisionradius) * 0.5 *0.075*FRand();
			s.Skin = GetMeshTexture();
			if (FRand() < 0.75)
				s.bSmoking = True;
		}
	}

	// cause the damage
	HurtRadius(explosionRadius, 8*explosionRadius, 'Exploded', 100*explosionRadius, Location);

destroy();
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
		LoopAnim('Fly');
		gotostate('hanging');
	}

	function EndState()
	{
		bCanConverse = true;
		bStasis = True;
		ResetReactions();
	}
}

state Hanging
{
	ignores EnemyNotVisible;

	function Tick(float deltaSeconds)
	{
		Global.Tick(deltaSeconds);
	}

	function EndState()
	{
		SetPhysics(PHYS_falling);//?
	}

	function ReactToInjury(Pawn instigatedBy, Name damageType, EHitLocation hitPos)
	{
	global.reacttoinjury(instigatedBy, damageType, hitPos);
	GotoState('Seeking');
	}
}

state Disabled //different yo.
{
	ignores bump, frob, reacttoinjury;

	event Landed(vector HitNormal)
	{
		if (velocity.z <= -500)
			smallexplode(hitnormal);
	}
	function BeginState()
	{
		BlockReactions(true);
		bCanConverse = False;
		SeekPawn = None;
		setphysics(PHYS_FALLING);
	}
	function EndState()
	{
		ResetReactions();
		bCanConverse = True;
	}

Begin:
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayDisabled();

Disabled:
}

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer;

	event Landed(vector HitNormal)
	{
		if (velocity.z <= -500)
			smallexplode(hitnormal);
	}

	function BeginState()
	{
 	gotostate('disabled');//hmmm?
	}

Begin:
	DesiredRotation.Pitch = 0;
	DesiredRotation.Roll  = 0;

	// if we don't gib, then wait for the animation to finish
	if ((Health > -100) && !IsA('Robot'))
		FinishAnim();

	SetWeapon(None);

	bHidden = True;

	Acceleration = vect(0,0,0);
}

function TakeDamageBase(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType, bool bPlayAnim)
{

	if (damageType == 'Shot')
	{
		Damage /= 0.25; // counteract what the inherited function will do
		Damage *= 0.75; // include our own, nicer damage mult.
	}

	super.takedamagebase(Damage, instigatedBy, hitlocation, momentum, damageType, bPlayAnim);
	if (health <= -20)
		smallexplode(HitLocation);
}

function ReactToInjury(Pawn instigatedBy, Name damageType, EHitLocation hitPos)
{
	local Pawn oldEnemy;

	if (IgnoreDamageType(damageType))
		return;

	if (EMPHitPoints > 0)
	{
		if (damageType == 'NanoVirus')
		{
			oldEnemy = Enemy;
			FindBestEnemy(false);
			if (oldEnemy != Enemy)
				PlayNewTargetSound();
			instigatedBy = Enemy;
		}
		Super.ReactToInjury(instigatedBy, damageType, hitPos);
	}
}


function Tick(float deltaSeconds)
{
	if (weapon != none)
		if (weapon.isa('weaponhoverbotsuicide'))
			if (!isinstate('disabled'))
				if ( enemy != none)
					if (vsize(enemy.location - location)<explosionradius)
						bigexplode(location);

	Super.Tick(deltaSeconds);
}

State Seeking
{
	function SetFall()
	{
		StartFalling('Seeking', 'ContinueSeek');
	}

	function HitWall(vector HitNormal, actor Wall)
	{
		if (Physics == PHYS_Falling)
			return;
		Global.HitWall(HitNormal, Wall);
		CheckOpenDoor(HitNormal, Wall);
	}

	function bool GetNextLocation(out vector nextLoc)
	{
		local float   dist;
		local rotator rotation;
		local bool    bDone;
		local float   seekDistance;
		local Actor   hitActor;
		local vector  HitLocation, HitNormal;
		local vector  diffVect;
		local bool    bLOS;

		if (bSeekLocation)
		{
			if (SeekType == SEEKTYPE_Guess)
				seekDistance = (200+FClamp(GroundSpeed*EnemyLastSeen*0.5, 0, 1000));
			else
				seekDistance = 300;
		}
		else
			seekDistance = 60;

		dist  = VSize(Location-destLoc);
		bDone = false;
		bLOS  = false;

		if (dist < seekDistance)
		{
			bLOS = true;
			foreach TraceVisibleActors(Class'Actor', hitActor, hitLocation, hitNormal,
			                           destLoc, Location+vect(0,0,1)*BaseEyeHeight)
			{
				if (hitActor != self)
				{
					if (hitActor == Level)
						bLOS = false;
					else if (IsPointInCylinder(hitActor, destLoc, 16, 16))
						break;
					else if (hitActor.bBlockSight && !hitActor.bHidden)
						bLOS = false;
				}
				if (!bLOS)
					break;
			}
		}

		if (!bLOS)
		{
			if (PointReachable(destLoc))
			{
				rotation = Rotator(destLoc - Location);
				if (seekDistance == 0)
					nextLoc = destLoc;
				else if (!AIDirectionReachable(destLoc, rotation.Yaw, rotation.Pitch, 0, seekDistance, nextLoc))
					bDone = true;
				if (!bDone && bDefendHome && !IsNearHome(nextLoc))
					bDone = true;
				if (!bDone)  // hack, because Unreal's movement code SUCKS
				{
					diffVect = nextLoc - Location;
					if (Physics == PHYS_Walking)
						diffVect *= vect(1,1,0);
					if (VSize(diffVect) < 20)
						bDone = true;
					else if (IsPointInCylinder(self, nextLoc, 10, 10))
						bDone = true;
				}
			}
			else
			{
				MoveTarget = FindPathTo(destLoc);
				if (MoveTarget == None)
					bDone = true;
				else if (bDefendHome && !IsNearHome(MoveTarget.Location))
					bDone = true;
				else
					nextLoc = MoveTarget.Location;
			}
		}
		else
			bDone = true;

		return (!bDone);
	}

	function bool PickDestination()
	{
		local bool bValid;

		bValid = false;
		if (/*(EnemyLastSeen <= 25.0) &&*/ (SeekLevel > 0))
		{
			if (bSeekLocation)
			{
				bValid  = true;
				destLoc = LastSeenPos;
			}
			else
			{
				bValid = AIPickRandomDestination(130, 250, 0, 0, 0, 0, 2, 1.0, destLoc);
				if (!bValid)
				{
					bValid  = true;
					destLoc = Location + VRand()*50;
				}
				else
					destLoc += vect(0,0,1)*BaseEyeHeight;
			}
		}

		return true; //return (bValid); //I have no idea wtf is going on here so I'll be surprised if it ends up working.
	}

	function NavigationPoint GetOvershootDestination(float randomness, optional float focus)
	{
		local NavigationPoint navPoint, bestPoint;
		local float           distance;
		local float           score, bestScore;
		local int             yaw;
		local rotator         rot;
		local float           yawCutoff;

		if (focus <= 0)
			focus = 0.6;

		yawCutoff = int(32768*focus);
		bestPoint = None;
		bestScore = 0;

		foreach ReachablePathnodes(Class'NavigationPoint', navPoint, None, distance)
		{
			if (distance < 1)
				distance = 1;
			rot = Rotator(navPoint.Location-Location);
			yaw = rot.Yaw + (16384*randomness);
			yaw = (yaw-Rotation.Yaw) & 0xFFFF;
			if (yaw > 32767)
				yaw  -= 65536;
			yaw = abs(yaw);
			if (yaw <= yawCutoff)
			{
				score = yaw/distance;
				if ((bestPoint == None) || (score < bestScore))
				{
					bestPoint = navPoint;
					bestScore = score;
				}
			}
		}

		return bestPoint;
	}

	function Tick(float deltaSeconds)
	{
		animTimer[1] += deltaSeconds;
		Global.Tick(deltaSeconds);
		UpdateActorVisibility(Enemy, deltaSeconds, 1.0, true);
	}

	/*function HandleLoudNoise(Name event, EAIEventState state, XAIParams params)
	{
		local Actor bestActor;
		local Pawn  instigator;

		if (state == EAISTATE_Begin || state == EAISTATE_Pulse)
		{
			bestActor = params.bestActor;
			if ((bestActor != None) && (EnemyLastSeen > 2.0))
			{
				instigator = Pawn(bestActor);
				if (instigator == None)
					instigator = bestActor.Instigator;
				if (instigator != None)
				{
					if (IsValidEnemy(instigator))
					{
						SetSeekLocation(instigator, bestActor.Location, SEEKTYPE_Sound);
						destLoc = LastSeenPos;
						if (bInterruptSeek)
							GotoState('Seeking', 'GoToLocation');
					}
				}
			}
		}
	}*/

	function HandleSighting(Pawn pawnSighted)
	{
		if ((EnemyLastSeen > 2.0) && IsValidEnemy(pawnSighted))
		{
			SetSeekLocation(pawnSighted, pawnSighted.Location, SEEKTYPE_Sight);
			destLoc = LastSeenPos;
			if (bInterruptSeek)
				GotoState('Seeking', 'GoToLocation');
		}
	}

	function BeginState()
	{
		setphysics(PHYS_flying); //added

		StandUp();
		Disable('AnimEnd');
		destLoc = LastSeenPos;
		SetReactions(true, true, false, true, true, true, true, true, true, false, true, true);
		bCanConverse = False;
		bStasis = False;
		SetupWeapon(true);
		SetDistress(false);
		bInterruptSeek = false;
		EnableCheckDestLoc(false);
	}

	function EndState()
	{
		EnableCheckDestLoc(false);
		Enable('AnimEnd');
		ResetReactions();
		bCanConverse = True;
		bStasis = True;
		StopBlendAnims();
		SeekLevel = 0;
	}

Begin:
	WaitForLanding();
	PlayWaiting();
	Acceleration = vect(0,0,0);
	if (!PickDestination())
		Goto('DoneSeek');

GoToLocation:
	bInterruptSeek = true;
	Acceleration = vect(0,0,0);

	if ((DeusExWeapon(Weapon) != None) && DeusExWeapon(Weapon).CanReload() && !Weapon.IsInState('Reload'))
		DeusExWeapon(Weapon).ReloadAmmo();

	if (bSeekPostCombat)
		PlayPostAttackSearchingSound();
	else if (SeekType == SEEKTYPE_Sound)
		PlayPreAttackSearchingSound();
	else if (SeekType == SEEKTYPE_Sight)
	{
		if (ReactionLevel > 0.5)
			PlayPreAttackSightingSound();
	}
	else if ((SeekType == SEEKTYPE_Carcass) && bSeekLocation)
		PlayCarcassSound();

	StopBlendAnims();

	if ((SeekType == SEEKTYPE_Sight) && bSeekLocation)
		Goto('TurnToLocation');

	EnableCheckDestLoc(true);
	while (GetNextLocation(useLoc))
	{
		if (ShouldPlayWalk(useLoc))
			PlayRunning();
		MoveTo(useLoc, MaxDesiredSpeed);
		CheckDestLoc(useLoc);
	}
	EnableCheckDestLoc(false);

	if ((SeekType == SEEKTYPE_Guess) && bSeekLocation)
	{
		MoveTarget = GetOvershootDestination(0.5);
		if (MoveTarget != None)
		{
			if (ShouldPlayWalk(MoveTarget.Location))
				PlayRunning();
			MoveToward(MoveTarget, MaxDesiredSpeed);
		}

		if (AIPickRandomDestination(CollisionRadius*2, 200+FRand()*200, Rotation.Yaw, 0.75, Rotation.Pitch, 0.75, 2,
		                            0.4, useLoc))
		{
			if (ShouldPlayWalk(useLoc))
				PlayRunning();
			MoveTo(useLoc, MaxDesiredSpeed);
		}
	}

TurnToLocation:
	Acceleration = vect(0,0,0);
	PlayTurning();
	if ((SeekType == SEEKTYPE_Guess) && bSeekLocation)
		destLoc = Location + Vector(Rotation+(rot(0,1,0)*(Rand(16384)-8192)))*1000;
	if (bCanTurnHead)
	{
		Sleep(0);  // needed to turn head
		LookAtVector(destLoc, true, false, true);
		TurnTo(Vector(DesiredRotation)*1000+Location);
	}
	else
		TurnTo(destLoc);
	bSeekLocation = false;
	bInterruptSeek = false;

	PlayWaiting();
	Sleep(FRand()*1.5+3.0);

LookAround:
	if (bCanTurnHead)
	{
		if (FRand() < 0.5)
		{
			if (!bSeekLocation)
			{
				PlayTurnHead(LOOK_Left, 1.0, 1.0);
				Sleep(1.0);
			}
			if (!bSeekLocation)
			{
				PlayTurnHead(LOOK_Forward, 1.0, 1.0);
				Sleep(0.5);
			}
			if (!bSeekLocation)
			{
				PlayTurnHead(LOOK_Right, 1.0, 1.0);
				Sleep(1.0);
			}
		}
		else
		{
			if (!bSeekLocation)
			{
				PlayTurnHead(LOOK_Right, 1.0, 1.0);
				Sleep(1.0);
			}
			if (!bSeekLocation)
			{
				PlayTurnHead(LOOK_Forward, 1.0, 1.0);
				Sleep(0.5);
			}
			if (!bSeekLocation)
			{
				PlayTurnHead(LOOK_Left, 1.0, 1.0);
				Sleep(1.0);
			}
		}
		PlayTurnHead(LOOK_Forward, 1.0, 1.0);
		Sleep(0.5);
		StopBlendAnims();
	}
	else
	{
		if (!bSeekLocation)
			Sleep(1.0);
	}

FindAnotherPlace:
	SeekLevel--;
	if (PickDestination())
		Goto('GoToLocation');

DoneSeek:
	if (bSeekPostCombat)
		PlayTargetLostSound();
	else
		PlaySearchGiveUpSound();
	bSeekPostCombat = false;
	SeekPawn = None;
		gotostate('hanging');

ContinueSeek:
ContinueFromDoor:
	FinishAnim();
	Goto('FindAnotherPlace');

}


State Attacking
{
	function EDestinationType PickDestination()
	{
		local vector               distVect;
		local vector               tempVect;
		local rotator              enemyDir;
		local float                magnitude;
		local float                calcMagnitude;
		local int                  iterations;
		local EDestinationType     destType;
		local NearbyProjectileList projList;

		destPoint = None;
		destLoc   = vect(0, 0, 0);
		destType  = DEST_Failure;

		if (enemy == None)
			return (destType);

		if (bCrouching && (CrouchTimer > 0))
			destType = DEST_SameLocation;

		if (destType == DEST_Failure)
		{
			if (AICanShoot(enemy, true, false, 0.025) || ActorReachable(enemy))
			{
				destType = ComputeBestFiringPosition(tempVect);
				if (destType == DEST_NewLocation)
					destLoc = tempVect;
			}
		}

		if (destType == DEST_Failure)
		{
			MoveTarget = FindPathToward(enemy);
			if (MoveTarget != None)
			{
				if (!bDefendHome || IsNearHome(MoveTarget.Location))
				{
					if (bAvoidHarm)
						GetProjectileList(projList, MoveTarget.Location);
					if (!bAvoidHarm || !IsLocationDangerous(projList, MoveTarget.Location))
					{
						destPoint = MoveTarget;
						destType  = DEST_NewLocation;
					}
				}
			}
		}

		// Default behavior, so they don't just stand there...

		if ((destType == DEST_Failure)||(destType == DEST_SameLocation))
		{
			enemyDir = Rotator(Enemy.Location - Location);
			tempvect = enemy.location;
			if (vsize(enemy.location - location) > hoverdistance)
			{
				while(vsize(enemy.location - tempvect) < hoverdistance)
				{
					if (AIPickRandomDestination(60, 150,
			  	           enemyDir.Yaw, 0.5, enemyDir.Pitch, 0.5, 
			                   2, FRand()*0.4+0.35, tempVect))
					{
						if (!bDefendHome || IsNearHome(tempVect))
						{
							destType = DEST_NewLocation;
							destLoc  = tempVect;
						}
					}
				}
			}
			else
			{
					if (AIPickRandomDestination(60, 150,
			                   enemyDir.Yaw, 0.5, enemyDir.Pitch, 0.5, 
			                   2, FRand()*0.4+0.35, tempVect))
					{
						tempvect *= -1;
						if (!bDefendHome || IsNearHome(tempVect))
						{
							destType = DEST_NewLocation;
							destLoc  = tempVect;
						}
					}
			}
		}

		return (destType);
	}

	function CheckAttack(bool bPlaySound)
	{
		local bool bCriticalDamage;
		local bool bOutOfAmmo;
		local Pawn oldEnemy;
		local bool bAllianceSwitch;

		oldEnemy = enemy;

		bAllianceSwitch = false;
		if (!IsValidEnemy(enemy))
		{
			if (IsValidEnemy(enemy, false))
				bAllianceSwitch = true;
			SetEnemy(None, 0, true);
		}

		if (enemy == None)
		{
			if (Orders == 'Attacking')
			{
				FindOrderActor();
				SetEnemy(Pawn(OrderActor), 0, true);
			}
		}
		if (ReadyForNewEnemy())
			FindBestEnemy(false);
		if (enemy == None)
		{
			Enemy = oldEnemy;  // hack
			if (bPlaySound)
			{
				if (bAllianceSwitch)
					PlayAllianceFriendlySound();
				else
					PlayAreaSecureSound();
			}
			Enemy = None;
			if (Orders != 'Attacking')
				FollowOrders();
			else
				GotoState('hanging');
			return;
		}

		SwitchToBestWeapon();
		if (bCrouching && (CrouchTimer <= 0) && !ShouldCrouch())
		{
			EndCrouch();
			TweenToShoot(0.15);
		}
		bCriticalDamage = False;
		bOutOfAmmo      = False;
		if (ShouldFlee())
			bCriticalDamage = True;
		else if (Weapon == None)
			bOutOfAmmo = True;
		else if (Weapon.ReloadCount > 0)
		{
			if (Weapon.AmmoType == None)
				bOutOfAmmo = True;
			else if (Weapon.AmmoType.AmmoAmount < 1)
				bOutOfAmmo = True;
		}
		if (bCriticalDamage || bOutOfAmmo)
		{
			if (bPlaySound)
			{
				if (bCriticalDamage)
					PlayCriticalDamageSound();
				else if (bOutOfAmmo)
					PlayOutOfAmmoSound();
			}
			if (RaiseAlarm == RAISEALARM_BeforeFleeing)
				GotoState('Alerting');
			else
				GotoState('Fleeing');
		}
		else if (bPlaySound && (oldEnemy != Enemy))
			PlayNewTargetSound();
	}

	function BeginState()
	{
		setphysics(PHYS_flying);
		StandUp();

		// hack
		if (MaxRange < MinRange+10)
			MaxRange = MinRange+10;
		bCanFire      = false;
		bFacingTarget = false;

		SwitchToBestWeapon();

		//EnemyLastSeen = 0;
		BlockReactions();
		bCanConverse = False;
		bAttacking = True;
		bStasis = False;
		SetDistress(true);

		CrouchTimer = 0;
		EnableCheckDestLoc(false);
	}

Begin:
	if (Enemy == None)
		GotoState('Seeking');
	//EnemyLastSeen = 0;
	CheckAttack(false);

Surprise:
	if ((1.0-ReactionLevel)*SurprisePeriod < 0.25)
		Goto('BeginAttack');
	Acceleration=vect(0,0,0);
	PlaySurpriseSound();
	PlayWaiting();
	while (ReactionLevel < 1.0)
	{
		TurnToward(Enemy);
		Sleep(0);
	}

BeginAttack:
	EnemyReadiness = 1.0;
	ReactionLevel  = 1.0;
	if (PlayerAgitationTimer > 0)
		PlayAllianceHostileSound();
	else
		PlayTargetAcquiredSound();
	if (PlayBeginAttack())
	{
		Acceleration = vect(0,0,0);
		TurnToward(enemy);
		FinishAnim();
	}

RunToRange:
	bCanFire       = false;
	bFacingTarget  = false;
	bReadyToReload = false;
	EndCrouch();
	if (Physics == PHYS_Falling)
		TweenToRunning(0.05);
	WaitForLanding();
	if (!IsWeaponReloading() || bCrouching)
	{
		if (ShouldPlayTurn(Enemy.Location))
			PlayTurning();
		TurnToward(enemy);
	}
	else
		Sleep(0);
	bCanFire = true;
	while (PickDestination() == DEST_NewLocation)
	{
		if (bCanStrafe && ShouldStrafe())
		{
			PlayRunningAndFiring();
			if (destPoint != None)
				StrafeFacing(destPoint.Location, enemy);
			else
				StrafeFacing(destLoc, enemy);
			bFacingTarget = true;
		}
		else
		{
			bFacingTarget = false;
			PlayRunning();
			if (destPoint != None)
				MoveToward(destPoint, MaxDesiredSpeed);
			else
				MoveTo(destLoc, MaxDesiredSpeed);
		}
		CheckAttack(true);
	}

Fire:
	bCanFire      = false;
	bFacingTarget = false;
	Acceleration = vect(0, 0, 0);

	SwitchToBestWeapon();
	if (FRand() > 0.5)
		bUseSecondaryAttack = true;
	else
		bUseSecondaryAttack = false;
	if (IsHandToHand())
		TweenToAttack(0.15);
	else if (ShouldCrouch() && (FRand() < CrouchRate))
	{
		TweenToCrouchShoot(0.15);
		FinishAnim();
		StartCrouch();
	}
	else
		TweenToShoot(0.15);
	if (!IsWeaponReloading() || bCrouching)
		TurnToward(enemy);
	FinishAnim();
	bReadyToReload = true;

ContinueFire:
	while (!ReadyForWeapon())
	{
		if (PickDestination() != DEST_SameLocation)
			Goto('RunToRange');
		CheckAttack(true);
		if (!IsWeaponReloading() || bCrouching)
			TurnToward(enemy);
		else
			Sleep(0);
	}
	CheckAttack(true);
	if (!FireIfClearShot())
		Goto('ContinueAttack');
	bReadyToReload = false;
	if (bCrouching)
		PlayCrouchShoot();
	else if (IsHandToHand())
		PlayAttack();
	else
		PlayShoot();
	FinishAnim();
	if (FRand() > 0.5)
		bUseSecondaryAttack = true;
	else
		bUseSecondaryAttack = false;
	bReadyToReload = true;
	if (!IsHandToHand())
	{
		if (bCrouching)
			TweenToCrouchShoot(0);
		else
			TweenToShoot(0);
	}
	CheckAttack(true);
	if (PickDestination() != DEST_NewLocation)
	{
		if (!IsWeaponReloading() || bCrouching)
			TurnToward(enemy);
		else
			Sleep(0);
		Goto('ContinueFire');
	}
	Goto('RunToRange');

ContinueAttack:
ContinueFromDoor:
	CheckAttack(true);
	if (PickDestination() != DEST_NewLocation)
		Goto('Fire');
	else
		Goto('RunToRange');

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
     explosionRadius=200.000000
     hoverdistance=200.000000
     EMPHitPoints=40
     MinHealth=100.000000
     bMustFaceTarget=True
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=Rogue,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Wildcat,AllianceLevel=-1.000000)
     InitialAlliances(3)=(AllianceName=Agentsmith,AllianceLevel=-1.000000)
     InitialAlliances(4)=(AllianceName=Kai,AllianceLevel=-1.000000)
     InitialAlliances(5)=(AllianceName=Carl,AllianceLevel=-1.000000)
     InitialAlliances(6)=(AllianceName=Security,AllianceLevel=-1.000000)
     InitialInventory(0)=(Inventory=Class'eWeaponDroneMG')
     bCanStrafe=True
	 Health=600
     AirSpeed=1280.000000
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExDeco.BlackHelicopter'
     DrawScale=0.700000
     CollisionRadius=210.000000
     CollisionHeight=43.760000
     BindName="DroneChopper"
     FamiliarName="Heli-Drone"
     UnfamiliarName="Heli-Drone"
	 SoundRadius=60
     SoundVolume=150
     AmbientSound=Sound'Ambient.Ambient.Helicopter2'
}
