//=============================================================================
// Original code by JimBowen, modified by Kai
//=============================================================================
class TRocket expands Rocket;

var AugmentationDisplayWindow win;
var gc gc;
var bowenviewportwindow vpw;
var bool bExploded, bDoneWin;
var rotator NewRotation;
var vector NewVelocity, NewLocation;

var bool bCompanion;
var(Bowen) sound LockedSound;

replication
{
	reliable if (Role == ROLE_Authority)
		bDoneWin, bExploded;

	unreliable if (Role == ROLE_Authority)
		NewRotation, NewVelocity, NewLocation;
}

simulated function HitWall (vector HitLocation, Actor Wall)
{
	if (vpw != None)
		vpw.Destroy();
	if (FireGen != None)
		FireGen.Destroy();
	if (SmokeGen != None)
		SmokeGen.Destroy();
	Super.HitWall (HitLocation, Wall);
}

auto simulated state flying
{
	simulated function tick(float deltatime)	
	{
		if(Role == ROLE_Authority || bNetOwner)	//dont do this on clients that didnt fire the rocket										
		{
			if(!bExploded)
			{
				if (bNetOwner)
				{
					if (FireGen != None)
						FireGen.Destroy();
					if (SmokeGen != None)
						SmokeGen.LifeSpan = 5;
					bDebris = False;
				}
				MakeWindow();
				SetDirection();
				SetRotation(NewRotation);
				Velocity = NewVelocity;
				//log("Nikita ticked");
			}
		}
		if(Role < ROLE_Authority && !bNetOwner)
		{
			SetRotation(NewRotation);
			Velocity = NewVelocity;
			SetLocation(NewLocation);
			SmokeGen.SetLocation(NewLocation);
			FireGen.SetLocation(NewLocation);
			//log("Nikita ticked on observing client, new rotation is: " @ NewRotation);
		}
		//log("Role = " @ Role @ ", bNetOwner = " @ bNetOwner); 
		Super.tick(DeltaTime);
	}
}

simulated function MakeWindow()	// adapted from DeusEx.AugmentationDisplayWindow.tick
{
	local String str;
	local float boxCX, boxCY, boxTLX, boxTLY, boxBRX, boxBRY, boxW, boxH;
	local float x, y, w, h, mult;
	local Vector loc;
	local float x2, y2, w2, h2, cx, cy;

		if ((Owner != None) && (Owner.IsA('DeusExPlayer')))
		{
			if ((Level.NetMode == NM_Client) || (Level.NetMode == NM_Standalone))
			{
				if (!bDoneWin)
				{	
					bDoneWin = True;
					win = DeusExRootWindow(DeusExPlayer(Owner).rootwindow).hud.augdisplay;
					gc = win.GetGC();
					vpw = BowenViewportWindow(win.NewChild(class'BowenViewportWindow'));
					vpw.projowner = Self;
				}
				else
				{
					vpw.AskParentForReconfigure();
					vpw.Lower();
					vpw.SetViewportActor(Self);
				}
				w2 = 512;
				h2 = 256;
				cx = (win.width/2) - 256;//+ win.margin;
				cy = (win.height/2) - 128;
				x2 = cx - w/2;
				y2 = cy - h/2;
				
				if (vpw != None)
					vpw.ConfigureChild(x2, y2, w2, h2);
			}			
		}
}

simulated function setdirection()
{
	NewRotation = (PlayerPawn(Owner).ViewRotation);
	NewVelocity = normal(vector(NewRotation))*speed;
	NewLocation = Location;
	//log("rotation to set (nikita) = " @ NewRotation);
}

simulated function destroyed()
{
local TLauncher TL;
	local TLItem h;
	DeusExPlayer(Owner).SetLocation(Location);
	DeusExPlayer(Owner).UnderWaterTime = DeusExPlayer(Owner).Default.UnderWaterTime;	
	DeusExPlayer(Owner).SetCollision(true, true , true);
	DeusExPlayer(Owner).SetPhysics(PHYS_Walking);
	DeusExPlayer(Owner).bCollideWorld = true;
	DeusExPlayer(Owner).bHidden=False;
	DeusExPlayer(Owner).GotoState('PlayerWalking');
	DeusExPlayer(Owner).ClientReStart();	
		if(bCompanion)
		{
		h=Spawn(class'TLItem', Self,, Location, Rotation);
		h.Frob(DeusExPlayer(Owner),None);
		h.bInObjectBelt = True;
		h.Destroy();
		}
	bExploded = True;
	if (vpw != None)
		vpw.Destroy();
	Super.Destroyed();
}
	
simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ShockRing ring;
	local SphereEffect sphere;
	local ExplosionLight light;
	local AnimatedSprite expeffect;

	// draw a pretty shock ring
	// For nano defense we are doing something else.
	if ((!bAggressiveExploded) || (Level.NetMode == NM_Standalone))
	{
			if(!bNetOwner)
			{
				ring = Spawn(class'ShockRing',,, HitLocation, rot(16384,0,0));
			if (ring != None)
				{
					ring.RemoteRole = ROLE_None;
					ring.size = blastRadius / 32.0;
				}
				ring = Spawn(class'ShockRing',,, HitLocation, rot(0,0,0));
				if (ring != None)
				{
					ring.RemoteRole = ROLE_None;
					ring.size = blastRadius / 32.0;
				}
				ring = Spawn(class'ShockRing',,, HitLocation, rot(0,16384,0));
				if (ring != None)
				{
					ring.RemoteRole = ROLE_None;
					ring.size = blastRadius / 32.0;
				}
			}
	}
	else
	{
		sphere = Spawn(class'SphereEffect',,, HitLocation, rot(16384,0,0));
		if (sphere != None)
		{
			sphere.RemoteRole = ROLE_None;
			sphere.size = blastRadius / 32.0;
		}
		sphere = Spawn(class'SphereEffect',,, HitLocation, rot(0,0,0));
		if (sphere != None)
		{
			sphere.RemoteRole = ROLE_None;
			sphere.size = blastRadius / 32.0;
		}
		sphere = Spawn(class'SphereEffect',,, HitLocation, rot(0,16384,0));
		if (sphere != None)
		{
			sphere.RemoteRole = ROLE_None;
			sphere.size = blastRadius / 32.0;
		}
	}
}

simulated function Tick(float deltaTime)
{
	local SmokeTrail s;

	time += DeltaTime;
	DrawScale = FClamp(2.5*(time+0.5), 1.0, 6.0);
	if ((time > FRand() * 0.02) && (Level.NetMode != NM_DedicatedServer))
	{
		time = 0;

		// spawn some trails
		s = Spawn(class'SmokeTrail',,, Location);
		if (s != None)
		{
			s.DrawScale = FRand() * 0.333;
			s.OrigScale = s.DrawScale;
			s.Texture = Texture'AlarmLightTex2';
			s.Velocity = VRand() * 50;
			s.OrigVel = s.Velocity;
		}
	}
}

//---END-CLASS---

defaultproperties
{
     LockedSound=Sound'DeusExSounds.Generic.Beep4'
     mpBlastRadius=5.000000
     blastRadius=5.000000
     ItemName="Travel Bomb"
     Damage=0.000000
     SpawnSound=Sound'DeusExSounds.UserInterface.DataLinkStart'
     ImpactSound=Sound'DeusExSounds.Weapons.EMPGrenadeExplode'
     ExplosionDecal=Class'DeusEx.BurnMark'
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex2'
     DrawScale=1.000000
     bAlwaysRelevant=True
     NetPriority=3.000000
}
