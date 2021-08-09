class WallHealer extends ElectronicDevices;


#exec OBJ LOAD FILE=Ambient

var() int healAmount;
var() int healRefreshTime;
var() int mphealRefreshTime;
var Float lastHealTime;

// ----------------------------------------------------------------------
// Network replication
// ----------------------------------------------------------------------
replication
{
	// MBCODE: Replicate the last time healed to the server
	reliable if ( Role < ROLE_Authority )
		lastHealTime, healRefreshTime;
}

// ----------------------------------------------------------------------
// PostBeginPlay()
// ----------------------------------------------------------------------

function PostBeginPlay()
{
	Super.PostBeginPlay();

   if (Level.NetMode != NM_Standalone)
   {
      healRefreshTime = mpHealRefreshTime;
   }
}

// ----------------------------------------------------------------------
// Frob()
// ----------------------------------------------------------------------

function Frob(Actor Frobber, Inventory frobWith)
{
   local DeusExPlayer player;
	local DeusExRootWindow root;
	local HUDMedBotAddAugsScreen winAug;
	local HUDMedBotHealthScreen  winHealth;
	local AugmentationCannister augCan;

   Super.Frob(Frobber, frobWith);
   
   player = DeusExPlayer(Frobber);

      if (CanHeal())
      {
			if ( Level.NetMode != NM_Standalone )
			{
				PlaySound(sound'MedicalHiss', SLOT_None,,, 256);
				if ( Frobber.IsA('DeusExPlayer') )
				{
					DeusExPlayer(Frobber).StopPoison();
					DeusExPlayer(Frobber).ExtinguishFire();
					DeusExPlayer(Frobber).drugEffectTimer = 0;
				}
			}
         HealPlayer(DeusExPlayer(Frobber));
      }
      else
      {
         Pawn(Frobber).ClientMessage("still charging, "$int(healRefreshTime - (Level.TimeSeconds - lastHealTime))$" seconds to go.");
      } 
}

// ----------------------------------------------------------------------
// HealPlayer()
// ----------------------------------------------------------------------

function int HealPlayer(DeusExPlayer player)
{
	local int healedPoints;

	if (player != None)
	{
		healedPoints = player.HealPlayer(healAmount);
		lastHealTime = Level.TimeSeconds;
	}
	return healedPoints;
}

// ----------------------------------------------------------------------
// CanHeal()
// 
// Returns whether or not the bot can heal the player
// ----------------------------------------------------------------------

function bool CanHeal()
{	
	return (Level.TimeSeconds - lastHealTime > healRefreshTime);
}

// ----------------------------------------------------------------------
// GetRefreshTimeRemaining()
// ----------------------------------------------------------------------

function Float GetRefreshTimeRemaining()
{
	return healRefreshTime - (Level.TimeSeconds - lastHealTime);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     healAmount=300
     healRefreshTime=15
     mphealRefreshTime=15
     bCanBeBase=True
     ItemName="Medical Station"
     Physics=PHYS_None
     Mesh=LodMesh'DeusExItems.MedKit'
     DrawScale=4.000000
     MultiSkins(0)=Texture'PGAssets.Skins.iMed'
     SoundRadius=8
     SoundVolume=96
     AmbientSound=Sound'Ambient.Ambient.HumLow3'
     CollisionRadius=23.000000
     CollisionHeight=5.000000
     Mass=20.000000
     Buoyancy=16.000000
}
