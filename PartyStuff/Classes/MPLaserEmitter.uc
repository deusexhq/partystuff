class MPLaserEmitter extends Effects;

#exec OBJ LOAD FILE=Effects

var LaserSpot spot[2];			// max of 2 reflections
var bool bIsOn;
var actor HitActor;
var bool bFrozen;				// are we out of the player's sight?
var bool bRandomBeam;
var bool bBlueBeam;				// is this beam blue?
var bool bHiddenBeam;			// is this beam hidden?

var LaserProxy proxy;
var bool bInitialized;


replication
{

    reliable if(Role == ROLE_Authority)
      proxy,bFrozen, spot, bRandomBeam;

    reliable if(Role == ROLE_Authority)
      bIsOn;
}

simulated function CalcTrace(float deltaTime)
{
	local vector StartTrace, EndTrace, HitLocation, HitNormal, Reflection;
	local actor target;
	local int i, texFlags;
	local name texName, texGroup;

	StartTrace = Location;
	EndTrace = Location + 5000 * vector(Rotation);
	HitActor = None;

	// trace the path of the reflected beam and draw points at each hit
	for (i=0; i<ArrayCount(spot); i++)
	{
		foreach TraceTexture(class'Actor', target, texName, texGroup, texFlags, HitLocation, HitNormal, EndTrace, StartTrace)
		{
			if ((target.DrawType == DT_None) || target.bHidden)
			{
				// do nothing - keep on tracing
			}
			else if ((target == Level) || target.IsA('Mover'))
			{
				break;
			}
			else
			{
				HitActor = target;
				break;
			}
		}

        if(spot[i] != none)
        {
		    Reflection = MirrorVectorByNormal(Normal(spot[i].location - StartTrace), HitNormal);
		    StartTrace = HitLocation + HitNormal;
		    EndTrace = Reflection * 10000;
        }

        if(Level.NetMode != NM_DedicatedServer)
        {
            //GetPlayerPawn().ClientMessage("calcing:"@deltaTime);
	    	// draw first beam
			if (i == 0)
			{
		   		// log("drawing at rot:"@Rotation);
				if (MPLaserIterator(RenderInterface) != None)
				    MPLaserIterator(RenderInterface).AddBeam(i, Location, rotator(spot[i].location - Location), VSize(Location - spot[i].location));
			}
			else
			{
				if (MPLaserIterator(RenderInterface) != None)
					MPLaserIterator(RenderInterface).AddBeam(i, StartTrace - HitNormal, Rotator(Reflection), VSize(StartTrace - spot[i].location - HitNormal));
			}
        }
        if(level.netmode != NM_Client)
        {
			if (spot[i] == None)
			{
				spot[i] = Spawn(class'LaserSpot', Self, , HitLocation, Rotator(HitNormal));
				spot[i].RemoteRole=ROLE_DumbProxy;
				spot[i].bAlwaysRelevant=true;
				spot[i].NetUpdateFrequency=10;
				if (bBlueBeam && (spot[i] != None))
					spot[i].Skin = Texture'LaserSpot2';
			}
			else
			{
			   // Broadcastmessage("oldloc="$spot[i].location$", newloc="$hitlocation);
				spot[i].SetLocation(HitLocation);
				spot[i].SetRotation(Rotator(HitNormal));
			}
        }
		// don't reflect any more if we don't hit a mirror
		// 0x08000000 is the PF_Mirrored flag from UnObj.h
		if ((texFlags & 0x08000000) == 0)
		{
			// kill all of the other spots after this one
			if (i < ArrayCount(spot)-1)
			{
				do
				{
					i++;
					if(level.netmode != NM_Client)
					{
					    if (spot[i] != None)
					    {
				  	        spot[i].Destroy();
				  	        spot[i] = None;
				  	    }
		  	        }
		  	        else if(Level.NetMode != NM_DedicatedServer)
						if (MPLaserIterator(RenderInterface) != None)
							MPLaserIterator(RenderInterface).DeleteBeam(i);

				} until (i>=ArrayCount(spot)-1);
			}

			return;
		}


	}
}

simulated function TurnOn()
{
	if (!bIsOn)
	{
		bIsOn = True;
		HitActor = None;
		//CalcTrace(0.0);
		if (!bHiddenBeam)
		{
			proxy.DrawType=DT_Mesh;
            proxy.bHidden = False;
		}
        SoundVolume = 45;
	}
}

simulated function TurnOff()
{
	local int i;

	if (bIsOn)
	{
		for (i=0; i<ArrayCount(spot); i++)
			if (spot[i] != None)
			{
				spot[i].Destroy();
				spot[i] = None;
			}

		HitActor = None;
		bIsOn = False;

		if (!bHiddenBeam)
		{
		    proxy.DrawType=DT_None;
			proxy.bHidden = True;
		}
		SoundVolume = 0;
	}
}

simulated function Destroyed()
{
	TurnOff();

	if (proxy != None)
	{
		proxy.Destroy();
		proxy = None;
	}

	Super.Destroyed();
}

simulated function Tick(float deltaTime)
{
	local DeusExPlayer player;
	local int i;

	// check for visibility
	player = DeusExPlayer(GetPlayerPawn());

	if (bIsOn)
	{
		// if we are a weapon's laser sight, do not freeze us
		if ((Owner != None) && (Owner.IsA('Weapon') || Owner.IsA('ScriptedPawn')))
			bFrozen = False;
		else if (proxy != None)
		{
			// if we are close, say 60 feet
			if (proxy.DistanceFromPlayer < 960)
				bFrozen = False;
			else
			{
				// can the player see the generator?
				if (proxy.LastRendered() <= 2.0)
					bFrozen = False;
				else
					bFrozen = True;
			}
		}
		else
			bFrozen = True;

		if (bFrozen)
			return;

		
		CalcTrace(deltaTime);
	}
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (proxy == None && level.netMode != NM_Client)
	{
		proxy = Spawn(class'LaserProxy',,, Location, Rotation);
		if(proxy != none)
		{
		    proxy.bAlwaysRelevant=bAlwaysRelevant;
		    proxy.NetUpdateFrequency=NetUpdateFrequency;
		}
		//proxy.Mesh=LodMesh'DeusExItems.NanoSwordPickup';
		if(bBlueBeam)
		  SetBlueBeam();
		//broadcastmessage("postbeginplay server("$level.netmode$").. proxy:"@proxy@"  proxyrot:"@proxy.rotation@"  skin:"@proxy.Skin);
    }
	if(level.netMode != NM_DedicatedServer)
      SetTimer(0.5,false);
//    log("pbp");
}

simulated function Timer()
{
    if(level.NetMode != NM_DedicatedServer)
	{
		//GetPlayerPawn().ClientMessage("timer called clientside("$level.netmode$").. proxy:"@proxy@"  proxyrot:"@proxy.rotation@"  skin:"@proxy.Skin);
		if(Proxy != none)
		{
			//GetPlayerPawn().ClientMessage("PROXY FOUND - setting old rotation ("$Rotation$") to new rotation:"@proxy.Rotation);
			SetRotation(proxy.Rotation);
			//GetPlayerPawn().ClientMessage("NEW ROTATION:"@Rotation);
			bInitialized=true;
			
		}
		else
			SetTimer(0.5,false);
	}
//      log("setting rotation to"@owner.Rotation);
	// create our proxy laser beam

}

function SetBlueBeam()
{
	bBlueBeam = True;
	if (proxy != None)
		proxy.Skin = Texture'LaserBeam2';
}

function SetHiddenBeam(bool bHide)
{
	bHiddenBeam = bHide;
	if (proxy != None)
		proxy.bHidden = bHide;
}

defaultproperties
{
     bBlueBeam=True
     bAlwaysRelevant=True
     SoundRadius=16
     AmbientSound=Sound'Ambient.Ambient.Laser'
     CollisionRadius=40.000000
     CollisionHeight=40.000000
     NetUpdateFrequency=15.000000
     RenderIteratorClass=Class'MPLaserIterator'
}
