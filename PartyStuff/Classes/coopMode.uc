class coopMode extends mutator;

function PostBeginPlay ()
{
	Super.PostBeginPlay ();
	Level.Game.BaseMutator.AddMutator (Self);
}

function ModifyPlayer(Pawn Other)
{
   local DeusExPickup DXP;
   local Augmentation Augz;
   
	super.ModifyPlayer(Other);
	
   foreach AllActors(Class'DeusExPickup', DXP)
   {
      if(DXP.Owner == DeusExPlayer(Other))
      {
         DXP.Destroy();
      }
   }
    DeusExPlayer(Other).AugmentationSystem.ResetAugmentations();
	ConsoleCommand("Admin KillAll AugLight");
	ConsoleCommand("Set AugLight Lifespan 0.1");
	    DeusExPlayer(Other).AugmentationSystem.ResetAugmentations();
}

defaultproperties
{
}
