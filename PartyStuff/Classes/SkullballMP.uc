class SkullballMP extends ThrownProjectile config(Skullball);

var bool bDoomedToDestroy;
var bool bAlreadyScored;

function bump(actor other)
{
local DeusExMover move;
local Weapon wep;
local ScriptedPawn P;
local DeusExDecoration Deco;
local DeusExPlayer Player;
local Basketball bask;
P = ScriptedPawn(other);
Move = DeusExMover(other);
Wep = Weapon(other);
Player = DeusExPlayer(other);
Deco = DeusExDecoration(other);
Bask = Basketball(other);

//Players
	if((other.IsA('DeusExPlayer')))
	{
	Player.ReducedDamageType = '';
    Player.TakeDamage(5000,Player,Player.Location,vect(0,0,0),'Exploded');
    Destroy();
	}

//Pawns
	if ((other.IsA('ScriptedPawn')))
	{
		P.binvincible=false;
		P.TakeDamage(5000,P,P.Location,vect(0,0,0),'Exploded');
		Destroy();
	}

//Deco
	if ((other.IsA('Decoration')))
	{
	Deco.bInvincible=False;
	Deco.TakeDamage(5000,P,P.Location,vect(0,0,0),'Exploded');
	Destroy();
	}
}


simulated function Timer()
{
	if (bDoomedToDestroy)
	{
		Destroy();
	}
	return;
}

simulated function Tick(float deltaTime)
{
	return;
}

simulated function TakeDamage(int Damage, Pawn instigatedBy, Vector HitLocation, Vector Momentum, name damageType)
{
	return;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	return;
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local SkullballMP4Player FLB4P;
	if (!bDoomedToDestroy)
	{
		FLB4P = Spawn(Class'SkullballMP4Player',Frobber,,Location,Rotation);
		DeusExPlayer(Frobber).FrobTarget = FLB4P;
		DeusExPlayer(Frobber).GrabDecoration();
		Super.Frob(Frobber, frobWith);
		Destroy();
	}
	else 
	{
		return;
	}
}

auto simulated state Flying
{
	simulated function HitWall(vector HitNormal, actor HitWall)
	{
		local float speed;
		
		Velocity = 0.8*((Velocity dot HitNormal) * HitNormal * (-2.0) + Velocity);
		speed = VSize(Velocity);
		bFixedRotationDir = True;
		RotationRate = RotRand(False);
		if ((speed > 0) && (speed < 30) && (HitNormal.Z > 0.7))
		{
			SetPhysics(PHYS_None, HitWall);
			if (Physics == PHYS_None)
				bFixedRotationDir = False;
		}
	
		if (HitWall.IsA('Mover'))
		{
			HitWall.TakeDamage(speed/58, Pawn(Owner), HitWall.Location, MomentumTransfer*Normal(Velocity), 'Shot');
		}
		
		else if (speed > 30)
		{	
			if ((FRand() >= 0.75) && (FRand() < 1.0))
			{
				PlaySound(sound'BasketballBounce', SLOT_None, 3);
			}
			else if ((FRand() >= 0.5) && (FRand() < 0.75))
			{
				PlaySound(sound'BasketballBounce', SLOT_None, 3);	
			}
			else
			{
				PlaySound(sound'BasketballBounce', SLOT_None, 3);	
			}
		}
	}
}

simulated function BeginPlay()
{
	Super.BeginPlay();
}

defaultproperties
{
     bDisabled=True
     bExplodes=False
     bBlood=False
     bEmitDanger=False
     bIgnoresNanoDefense=True
     ItemName="Skull ball"
     LifeSpan=0.000000
     bDirectional=False
     Mesh=LodMesh'DeusExDeco.BoneSkull'
     CollisionRadius=15.000000
     CollisionHeight=15.000000
     Drawscale=1.5
     bBlockActors=True
     bBlockPlayers=True
     Mass=8.000000
     Buoyancy=10.000000
}
