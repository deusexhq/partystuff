//=============================================================================
// FlagPole.
//=============================================================================
class CaptureFlag extends DeusExDecoration;

var bool bDontRespawn;
var() int CP;

function Bump(actor Other)
{
	local PGGames PGG;
	local CapturePoint cpo;

	cpo = CapturePoint(Other);
	if(cpo != None && cpo.CP == CP)
	{
	cpo.CPoints++;
BroadcastMessage("Score on CapturePoint "$cpo.CP$"! Now "$cpo.CPoints$"!");


	if(cpo.CPoints == cpo.CWin)
	{
	BroadcastMessage("CapturePoint "$cpo.CP$" has won!");
		foreach AllActors(class'capturepoint',CPO)
			cpo.cpoints = 0;
	Destroy();
	bDontRespawn=True;
		foreach AllActors(class'PGGames',PGG)
			PGG.bCOn=False;
	}
	Boom();	
	}

}

function Boom()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionRadius;
	local captureflagspawner cf;
	explosionRadius = 150;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;
	
	Destroy();
		
	if(bdontrespawn)
		return;
	foreach AllActors(class'CaptureFlagSpawner',CF)
		if(CF.CP == CP)
			CF.SetTimer(10,False);
}

defaultproperties
{
     FragType=Class'DeusEx.WoodFragment'
	 bInvincible=True
     ItemName="Capture Flag"
     Mesh=LodMesh'DeusExDeco.FlagPole'
     CollisionRadius=17.000000
     CollisionHeight=56.389999
     Mass=40.000000
     Buoyancy=30.000000
}
