class SkullBallMP4Player extends DeusExDecoration;

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
	Deco.TakeDamage(5000,P,P.Location,vect(0,0,0),'Exploded');
	    Destroy();
	}
}


event BaseChange()
{
	local SkullballMP AdvB;
	if (bWasCarried)
	{
		AdvB = Spawn(Class'SkullBallMP',Owner,,Location,Rotation);
		AdvB.Velocity = Velocity + 0.7 * Owner.Velocity;
		Destroy();
	}
}

defaultproperties
{
     bInvincible=True
     ItemName="Skull"
     Mesh=LodMesh'DeusExDeco.BoneSkull'
     DrawScale=0.600000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bBounce=True
     Mass=8.000000
     Buoyancy=10.000000
}
