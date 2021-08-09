//=============================================================================
// WaterRing.
//=============================================================================
class psTeleRing1 extends Actor;

var DeusExPlayer Target;
var int QT;
var vector OriginLoc, TPLoc;
var float size;

simulated function Tick(float deltaTime)
{
	DrawScale = size * (Default.LifeSpan - LifeSpan) / Default.LifeSpan;
	ScaleGlow = LifeSpan / Default.LifeSpan;
}

/*- Q 0 = Spawns 2, Q1 and Q2, +- 25
 *a Q 1 = Spawns 1, Q3 +50
 *a Q 2 = Spawns 1, Q4 -50
 *b Q 3 = Spawns 1, Q5 +75
 *b Q 4 = Spawns 1, Q6 -75 +Teleport
 */
 
function Timer()
{
	local psTeleRing1 pn1, pn2;
	local vector finLoc;
	local PSAfterEffect PSAE;
	
	if(QT==0)
	{
		if(Target != None)
			finLoc = Target.Location;		
		else
			finLoc = OriginLoc;
			
		finloc.Z += 25;
		
		pn1 = Spawn(class'psTeleRing1',,,finLoc);
		pn1.QT = 1;
		pn1.Target = Target;
		pn1.TPLoc = TPLoc;
		
		if(Target != None)
			finLoc = Target.Location;		
		else
			finLoc = OriginLoc;
			
		finloc.Z -= 25;
		
		pn2 = Spawn(class'psTeleRing1',,,finLoc);
		pn2.QT = 2;
		pn2.Target = Target;
		pn2.TPLoc = TPLoc;
	}
	
	if(QT==1)
	{
		if(Target != None)
			finLoc = Target.Location;		
		else
			finLoc = OriginLoc;
			
		finloc.Z += 50;
		
		pn1 = Spawn(class'psTeleRing1',,,finLoc);
		pn1.QT = 3;
		pn1.Target = Target;
		pn1.TPLoc = TPLoc;
	}
	
	if(QT==2)
	{
		if(Target != None)
			finLoc = Target.Location;		
		else
			finLoc = OriginLoc;
			
		finloc.Z -= 50;
		
		pn1 = Spawn(class'psTeleRing1',,,finLoc);
		pn1.QT = 4;
		pn1.Target = Target;
		pn1.TPLoc = TPLoc;
	}
	
	if(QT==3)
	{
		if(Target != None)
			finLoc = Target.Location;		
		else
			finLoc = OriginLoc;
			
		finloc.Z += 75;
		
		pn1 = Spawn(class'psTeleRing1',,,finLoc);
		pn1.QT = 5;
		pn1.Target = Target;
		pn1.TPLoc = TPLoc;
	}
	
	if(QT==4)
	{
		if(Target != None)
			finLoc = Target.Location;		
		else
			finLoc = OriginLoc;
			
		finloc.Z -= 75;
		
		pn1 = Spawn(class'psTeleRing1',,,finLoc);
		pn1.QT = 6;
		pn1.Target = Target;
		pn1.TPLoc = TPLoc;
	}
	
	if(QT==6)
	{
		PSAE = Spawn(class'PSAfterEffect');
		PSAE.AttachToPlayer(Target);
		Target.bMovable=True;
		Target.SetCollision(false, false, false);
		Target.bCollideWorld = true;
		Target.GotoState('PlayerWalking');
		Target.SetLocation(TPLoc);
		Target.SetCollision(true, true , true);
		Target.SetPhysics(PHYS_Walking);
		Target.bCollideWorld = true;
		Target.GotoState('PlayerWalking');
		Target.ClientReStart();
		
	}
}

function PostBeginPlay()
{
	local Rotator rot;

	Super.PostBeginPlay();
	
	rot.Pitch = 16384;
	rot.Roll = 0;
	rot.Yaw = Rand(65535);
	SetRotation(rot);
	
	if (size > 5)
		Skin = Texture'FlatFXTex43';
	
	SetTimer(0.7,False);
}

defaultproperties
{
     size=5.000000
     LifeSpan=0.500000
     DrawType=DT_Mesh
     Style=STY_Translucent
     Skin=Texture'DeusExItems.Skins.FlatFXTex41'
     Mesh=LodMesh'DeusExItems.FlatFX'
     bUnlit=True
}
