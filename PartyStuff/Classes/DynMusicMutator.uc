class DynMusicMutator extends Mutator
config (DynMusic);

var() config music BattleTrack;
var() config EMusicTransition Transition;
var() config byte             BattleSongSection, SongSection;
var() config byte             BattleCdTrack, CdTrack;
var() config string BattleEnterMsg, BattleExitMsg;

function PostBeginPlay ()
{
	Level.Game.BaseMutator.AddMutator (Self);
		super.PostBeginPlay();
}

function ModifyPlayer(Pawn Other)
{
	local DeusExPlayer P;
	local DynMusicActor DA;
	local bool bFound;
	super.ModifyPlayer(Other);
	P = DeusExPlayer(Other);
	
	if(P != None)
	{
		foreach AllActors(class'DynMusicActor', DA)
		{
			if(DA.Watcher == P)
				bFound=True;
		}
		
		
		if(!bFound)
		{
			DA = Spawn(class'DynMusicActor',,,P.Location);
			DA.Watcher = P;
			DA.DM = Self;
			Log("Dynamic music attached.");
		}
	}
	
}

defaultproperties
{
}
