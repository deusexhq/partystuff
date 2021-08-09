class DroneBoxRespawner extends Actor;

function Timer()
{
Spawn(class'DroneBox',,,Location);
BroadcastMessage("A new drone container has been delivered.");
destroy();
}

defaultproperties
{
     bHidden=True
}
