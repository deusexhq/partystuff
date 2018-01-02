class CaptureFlagSpawner extends PGSpawnPoints;

var() int CP;

function Timer()
{
	local CaptureFlag CF;
	
	CF = spawn(class'CaptureFlag',,,location);
	CF.CP = CP;
	BroadcastMessage("Capture Flag has spawned.");
}

defaultproperties
{
}
