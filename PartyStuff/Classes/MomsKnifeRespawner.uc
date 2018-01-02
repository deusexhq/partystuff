class MomsKnifeRespawner extends PGActors;
var PlayerPawn Giver;

function Timer()
{
	SilentAdd(class'WeaponMomsKnife', DeusExPlayer(Giver));
destroy();
}

function SilentAdd(class<inventory> addClass, DeusExPlayer addTarget)
{ 
	local Inventory anItem;
	
	anItem = Spawn(addClass,,,addTarget.Location); 
	anItem.SpawnCopy(addTarget);
	anItem.Destroy();
	/*anItem.Instigator = addTarget; 
	anItem.GotoState('Idle2'); 
	anItem.bHeldItem = true; 
	anItem.bTossedOut = false; 
	
	if(Weapon(anItem) != None) 
		Weapon(anItem).GiveAmmo(addTarget); 
	anItem.GiveTo(addTarget);*/
}

defaultproperties
{
bHidden=True
}
