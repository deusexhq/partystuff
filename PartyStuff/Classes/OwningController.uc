class OwningController extends Mutator
config(Owning);

var config string Owners[30];

function PostBeginPlay()
{
local OwnedScanner2 OS;

	Log("OwnedScanner mutator enabled.",'TC');
	Level.Game.BaseMutator.AddMutator (Self);
	
	foreach AllActors(class'OwnedScanner2', OS)
	{
		OS.myController = Self;
	}
}

function Mutate(string MutateString, PlayerPawn Sender)
{
	local Actor hitActor;
	local vector loc, line, HitLocation, hitNormal;
	local string inputstr;
	local int inputint;
	
	
	   	super.Mutate(MutateString, Sender);
		
		if(MutateString ~= "sell")
		{
			loc = Sender.Location;
			loc.Z += Sender.BaseEyeHeight;
			line = Vector(Sender.ViewRotation) * 4000;
			HitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
			
			if(OwnedScanner2(HitActor) != None && Owners[OwnedScanner2(HitActor).ReadNumber] != "" && Owners[OwnedScanner2(HitActor).ReadNumber] == Sender.PlayerReplicationInfo.PlayerName)
			{
				Owners[OwnedScanner2(HitActor).ReadNumber] = "";
				Sender.ClientMessage("Object sold.");
			}
		}
		
		if(Left(MutateString,5) ~= "find ")
        {
		   inputint = int(Right(MutateString, Len(MutateString) - 5));
		   Sender.ClientMessage(Owners[inputint]);
		}
		
		if(Left(MutateString,6) ~= "clear ")
        {
		   inputint = int(Right(MutateString, Len(MutateString) - 6));
		   if(Sender.bAdmin)
		   {
			    Sender.ClientMessage("|P2Deleting "$Owners[inputint]);
			   Owners[inputint] = "";
		   }
		}
}

defaultproperties
{
}
