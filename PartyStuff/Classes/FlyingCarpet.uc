class FlyingCarpet extends HKMarketTarp;

var bool bActive;
#exec obj load file=..\Textures\HK_Interior.utx package=HK_Interior

function SilentAdd(class<inventory> addClass, DeusExPlayer addTarget)
{ 
	local Inventory anItem;
	
	anItem = Spawn(addClass); 
	anItem.Instigator = addTarget; 
	anItem.GotoState('Idle2'); 
	anItem.bHeldItem = true; 
	anItem.bTossedOut = false; 
	
	if(Weapon(anItem) != None) 
		Weapon(anItem).GiveAmmo(addTarget); 
	anItem.GiveTo(addTarget);
}

function Frob(Actor Frobber, Inventory frobWith)
{
 local PortableCarpet cdc;
	if(bActive)
	{
		bActive=False;
		Destroy();
		SilentAdd(class'PortableCarpet', DeusExPlayer(Frobber));
		return;
	}

}

defaultproperties
{
     bActive=True
     bInvincible=True
     bCanBeBase=True
     Texture=Texture'HK_Interior.Textile.HKM_Rug_04'
     Skin=Texture'HK_Interior.Textile.HKM_Rug_04'
}
