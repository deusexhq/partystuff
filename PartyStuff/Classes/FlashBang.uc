class FlashBang expands ThrownProjectile;

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
local DeusExPlayer player;
local ScriptedPawn pwn;
local Float TargetRange;
	
	targetRange = 12;
	foreach VisibleActors(class'DeusExPlayer',player,768)
	{
		TargetRange -= Abs(VSize(Player.Location - Location));
		player.ClientFlash(1,Vect(20000,20000,20000));
		player.IncreaseClientFlashLength(12.0);
		
	}
	foreach VisibleActors(class'ScriptedPawn',pwn,768)
	{
		pwn.TakeDamage(5,Pawn(Owner),pwn.Location,vect(0,0,0),'TearGas');
	}
}

defaultproperties
{
     fuseLength=3.000000
     proxRadius=128.000000
     spawnWeaponClass=Class'PartyStuff.WeaponFlashBang'
     spawnAmmoClass=Class'PartyStuff.AmmoFlashBang'
     ItemName="Flash Bang Grenade"
     speed=1500.000000
     ImpactSound=Sound'DeusExSounds.Generic.SmallExplosion2'
     Mesh=LodMesh'DeusExItems.EMPGrenadePickup'
}
