//=============================================================================
// Vortex
//=============================================================================
class Vortex extends Projectile;

//var chunktrail trail;
var int TickDelay;
var int Ticks;
var bool bVAdded, bPlayedStartSound;
var bool bVortexSucking,bVortexStopped;
var float VortexGravity, VortexRadius;
var SphereEffectXL sp;

var() localized string DirectHitString, SuicideString, SuicideFString;
var() float DamageRadius;

replication
{
   Reliable if ( Role == Role_Authority )
      bVortexSucking;
}

simulated function PostBeginPlay()
{

   Super.PostBeginPlay();
   
   Velocity = Vector(Rotation) * Speed;
   Velocity.Z += 200;
   SetTimer(0.05, True);
   RandSpin(30000);
}


simulated function Tick (float DeltaTime)
{
	//spawns lightballs all around
	if(bVortexSucking)
		SpawnLights();
	
   if ( Ticks - TickDelay == 15 )
   {
      if ( !bVAdded )
      {
          Velocity.Z += 15;
         bVAdded = True;
      }
   }
   
   if ( Ticks - TickDelay > 15 )
      Velocity -= Region.Zone.ZoneGravity * DeltaTime * 0.8;
   
   if ( Ticks - TickDelay > 25 )
      DrawScale = Min(1 + ((Ticks - TickDelay) - 25) * 0.25, 2.0);

   if ( Ticks - TickDelay == 40 )
   {
	  
	  //Owner.PlaySound(Sound'DXRVUltimate.Effect.Teleport01',SLOT_None,16384);
      Velocity = vect(0,0,0);
      SetPhysics(PHYS_Rotating);
	  bVortexSucking = True;
   }
   
   //if ( Ticks - TickDelay == 70 )
    //     bVortexSucking = True;
   
   if ( Ticks - TickDelay == 300)
   {
      AmbientSound = None;
      PlaySound(MiscSound,, 255.0,, 6000.00);
   }
   else if ( Default.LifeSpan - LifeSpan > 6.0 + TickDelay * 0.05 && AmbientSound == None )
   {	
      //AmbientSound = Sound'DXRVUltimate.Effect.VortexRun';
      SoundVolume = 255;
      SoundRadius = 6000;
   }
   else if ( Default.LifeSpan - LifeSpan > TickDelay * 0.05 && !bPlayedStartSound )
   {
      PlaySound(SpawnSound,, 255.0,, 6000.00);
      bPlayedStartSound = True;
   }
}

simulated function Destroyed()
{
	bVortexSucking = False;

}


simulated function LoopRunAnim(float Rate)
{
  // LoopAnim('VortexRun', Rate);
}


simulated function SetVictimPhysics(actor Victim)
{
   if ( Victim.Physics != PHYS_Falling && (!Victim.IsA('Pawn') || !Victim.Region.Zone.bWaterZone) ) 
   {
      Victim.SetPhysics(PHYS_Falling);
      if ( Victim.IsA('Pawn') )
         Pawn(Victim).Falling();
   }
}


function SetKillType(Pawn Killer, Pawn Victim)
{
   if ( Killer == None || Victim == None )
      return;
   if ( Killer != Victim )
      Level.Game.SpecialDamageString = DirectHitString;
   else if ( Killer.bIsFemale )
      Level.Game.SpecialDamageString = SuicideFString;
   else
      Level.Game.SpecialDamageString = SuicideString;
}


function SplashDamage()
{
   local actor Victim;
   local float dist, damageScale;

   if ( bHurtEntry )
      return;
   bHurtEntry = true;

   foreach VisibleCollidingActors(class 'Actor', Victim, DamageRadius, Location)
      if ( Victim != Self ) {
         dist = FMax(1, VSize(Victim.Location - Location));
         damageScale = 1 - FClamp((dist - Victim.CollisionRadius) / DamageRadius, 0, 1);
         SetKillType(Instigator, Pawn(Victim));
         Victim.TakeDamage(damageScale * Damage, Instigator, Victim.Location, vect(0,0,0), MyDamageType);
      }

   bHurtEntry = false;
}


simulated function VortexTarget()
{
   local float Distance;
   local vector Direction;
   local Actor Victim;
   local bool bVictimInSight;

   // suck (almost) everything in
   ForEach RadiusActors(class'Actor', Victim, VortexRadius, Location)
   {
	   if(Victim!=Owner)
	   {
	      bVictimInSight = FastTrace(Location, Victim.Location);

	       if (Victim.Class != Class && !Victim.IsA('StationaryPawn')  &&  !Victim.bHidden && Victim.Physics != PHYS_Trailer &&  ( (Victim.bIsPawn || Victim.IsA('Carcass')) || Victim.IsA('TranslocatorTarget') || ( (Victim.IsA('Projectile') && Victim.Physics == PHYS_Falling) )   ) )
	       {
	         if ( Pawn(Victim) == None || !Pawn(Victim).bIsPlayer || !Pawn(Victim).PlayerReplicationInfo.bIsSpectator )
	         {
	            Direction = Location - Victim.Location;
	            Distance = 2.1 - VSize(Direction * 2) / VortexRadius;
	            Direction = Normal(Direction);
	            if ( !bVictimInSight )
	               Direction *= 0.3;
	            SetVictimPhysics(Victim);
	            Victim.Velocity += Direction * VortexGravity * 0.2 * Square(Distance);
	         }
	        }
			
	      if ( Victim.Role == ROLE_Authority && Victim.bIsPawn
	            && (bVictimInSight || VSize(Location - Victim.Location) < VortexRadius * 0.8) )
	      {
	         Pawn(Victim).FearThisSpot(Self);
	      }
		  
	      if (Victim.bIsPawn &&  Role == ROLE_Authority  && Pawn(Victim).Health > 0 && bVictimInSight
	            && VSize(Location - Victim.Location) < DamageRadius * 0.4 )
	      {
	         SetKillType(Instigator, Pawn(Victim));
	         Pawn(Victim).Health = -1000;
	         Pawn(Victim).Died(Instigator, MyDamageType, Victim.Location);
	      }
	  }
   }
   SplashDamage();
}


simulated function Landed( vector HitNormal )
{
   HitWall(HitNormal, None);
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
   HitWall(Normal(HitLocation - Other.Location), None );
}

simulated function HitWall( vector HitNormal, actor Wall )
{
   Velocity = 0.75 * ((Velocity dot HitNormal) * HitNormal * (-2.0) + Velocity);   // Reflect off Wall w/damping
   speed = VSize(Velocity);
   if ( Velocity.Z > 400 )
      Velocity.Z = 0.5 * (400 + Velocity.Z);
}


simulated function Timer()
{
   SetTimer(0.05, True);
   LoopRunAnim(Min(0.25 + (Ticks * 0.05), 1.0));
   Ticks += 1;
   Velocity -= Velocity * 0.1;
   if ( bVortexSucking )
      VortexTarget();
}

function SpawnLights()
{
	local int randomheight,randomNum;
	local vector vec1,summonLocation, PlayerHitLocation;
	local LightBall lightB;

	randomheight=Rand(40);
	randomNum=Rand(4);

	vec1=VRand();
	vec1*=500;

	summonLocation = vec1+Location;
	summonLocation.z += randomheight;
	PlayerHitLocation = Location;
	PlayerHitLocation.z += randomheight;

	lightB=Spawn(class'LightBall',,, summonLocation, rotator(PlayerHitLocation-summonLocation));
	if (lightB!=None)
	{
			lightB.Texture=Texture'DeusExDeco.Skins.AlarmLightTex6';
			lightB.TimeLimit=1.5;
	}	
}

defaultproperties
{
     VortexGravity=120.000000
     VortexRadius=7000.000000
     DamageRadius=200.000000
     speed=600.000000
     Damage=10.000000
     MyDamageType=SpecialDamage
     LifeSpan=20.000000
     Skin=FireTexture'Effects.liquid.Virus_SFX'
     Mesh=LodMesh'DeusExDeco.Basketball'
     AmbientGlow=67
     bUnlit=True
     SoundRadius=112
     SoundVolume=255
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bBounce=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
