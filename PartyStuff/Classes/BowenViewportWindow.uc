//=============================================================================
// BowenViewportWindow. 	(c) 2003 JimBowen  
// (but also with a f***load copied from AugmentationDisplayWindow, for the night vision effect)
//=============================================================================
class BowenViewportWindow expands ViewportWindow;

var trocket projowner;
var float TestTime;

var(Bowen) Color colBackground;
var(Bowen) Color colBorder;
var(Bowen) Color colHeaderText;
var(Bowen) Color colText;

var bool bVisionActive;
var(Bowen) int visionLevel;
var(Bowen) float visionLevelValue;
var int activeCount;

var(Bowen) float margin;
var(Bowen) float corner;

var Actor VisionBlinder; //So the same thing doesn't blind me twice.

var int VisionTargetStatus; //For picking see through wall texture
const VISIONENEMY = 1;
const VISIONALLY = 2;
const VISIONNEUTRAL = 0;

var (Bowen) String msgLightAmpActive;
var (Bowen) String msgIRAmpActive;

var DeusExPlayer Player;

event InitWindow()
{
	Super.InitWindow();
	bTickEnabled = True;
}

function tick (float deltatime)
{
	Player = DeusExPlayer(ProjOwner.Owner);
		
	if(ProjOwner.bExploded)
		Destroy();
}

//---END-CLASS---

defaultproperties
{
     colBackground=(R=128,G=128,B=128)
     colBorder=(R=128,G=128,B=128)
     colHeaderText=(R=255,G=255,B=255)
     colText=(R=255,G=255,B=255)
     visionLevel=1
     visionLevelValue=1000000.000000
     margin=4.000000
     corner=9.000000
     msgLightAmpActive="LightAmp Active"
     msgIRAmpActive="IRAmp Active"
}
