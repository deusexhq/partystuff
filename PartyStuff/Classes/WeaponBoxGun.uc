//=============================================================================
// WeaponBoxGun.
//=============================================================================
class WeaponBoxGun expands WeaponLAW;

var int currentMode;
var Box currentBox;
var string cycleMessages[5];
var float createSize;
var travel Texture CurSkin;
var travel byte SkinMode;

#exec obj load file=..\Textures\Extras.utx package=Extras
#exec obj load file=..\Textures\Effects.utx package=Effects

replication
{
     reliable if (Role == ROLE_Authority)
        createSizeWindow, currentMode;

     reliable if (Role < ROLE_Authority)
        setSize, createBox;
}

function GiveTo( pawn Other )
{
    super.Giveto(Other);
        CurSkin = Texture'CoreTexDetail.Detail.DStone_A';
	Other.ClientMessage("SCOPE to change skin. AMMO CHANGE to change mode.");
}

Function ScopeToggle()
{
    local DeusExplayer P;
    P=DeusExPlayer(Owner);
        
    if (SkinMode == 0)
    {
        SkinMode = 1;
        CurSkin = Texture'DeusExDeco.Skins.AlarmLightTex3';
	DeusExPlayer(Owner).Clientmessage("|P3Red Box");
        return;
    }
    if (SkinMode == 1)
    {
        SkinMode = 2;
        CurSkin = Texture'DeusExDeco.Skins.AlarmLightTex5';
	DeusExPlayer(Owner).Clientmessage("|P3Green Box");
        return;
    }
    if (SkinMode == 2)
    {
        SkinMode = 3;
        CurSkin = Texture'DeusExDeco.Skins.AlarmLightTex7';
	DeusExPlayer(Owner).Clientmessage("|P3Blue Box");
        return;
    }
    if (SkinMode == 3)
    {
        SkinMode = 4;
        CurSkin = Texture'DeusExDeco.Skins.AlarmLightTex9';
	DeusExPlayer(Owner).Clientmessage("|P3Gold Box");
        return;
    }
    if (SkinMode == 4)
    {
        SkinMode = 5;
        CurSkin = Texture'Extras.Eggs.Matrix_A00';
	DeusExPlayer(Owner).Clientmessage("|P3Matrix Box");
        return;
    }
    if (SkinMode == 5)
    {
        SkinMode = 6;
        CurSkin = Texture'Effects.water.bluewater_a';
	DeusExPlayer(Owner).Clientmessage("|P3Water Box");
        return;
    }
    if (SkinMode == 6)
    {
        SkinMode = 0;
        CurSkin = Texture'CoreTexDetail.Detail.DStone_A';
	DeusExPlayer(Owner).Clientmessage("|P3Default Box");
        return;
    }
}

function setSize(float newSize, int sizeType)
{
	if(newSize > 5)
		newSize = 5.00000;

	if(sizeType == 1 && currentBox != None)
	{
		currentBox.DrawScale = currentBox.Default.DrawScale*newSize;
		currentBox.SetCollisionSize(currentBox.Default.CollisionRadius*newSize,currentBox.Default.CollisionHeight*newSize);
	}
	else if(sizeType == 2)
	{
		createSize = newSize;
	}
}

simulated function createSizeWindow()
{
	local DeusExPlayer _Player;
	local DeusExRootWindow _root;
	local BoxSizeWindow _boxWindow;
	_Player = DeusExPlayer(Owner);
	if(_Player != None)
	{
		_Player.InitRootWindow();
		_root = DeusExRootWindow(_Player.rootWindow);
		if(_root != None)
		{
			_boxWindow = BoxSizeWindow(_root.InvokeUIScreen(Class'BoxSizeWindow', True));
			if(_boxWindow != None)
			{
				_boxWindow._windowOwner = self;
			}
		}
	}
}

function createBox(vector spawnLocation)
{
	local Box _newBox;
	_newBox = Spawn (class'Box',,, spawnLocation);
	if(_newBox != None)
	{
		_newBox.SetRotation(_newBox.Default.Rotation);
		_newBox.DrawScale = _newBox.Default.DrawScale*createSize;
		_newBox.Skin = CurSkin;
		_newBox.Texture = CurSkin;
		_newBox.Multiskins[0] = CurSkin;
		 _newBox.CreatedBy = DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName;
		_newBox.SetCollisionSize(_newBox.Default.CollisionRadius*createSize,_newBox.Default.CollisionHeight*createSize);
	}
}

simulated function cycleammo()
{

	if(currentMode == 3 && currentBox != None)
	{
		currentBox = None;
	}

	currentMode++;
	if(currentMode > 4)
	{
		currentMode = 0;
	}
	DeusExPlayer(Owner).ClientMessage(cycleMessages[currentMode]);

}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local vector spawnLocation;

	if(currentMode == 0)
	{
		spawnLocation = HitLocation;

		if(Box(Other) != None)
			spawnLocation.Z += (Class'Box'.Default.CollisionHeight*createSize) / 2;

		createBox(spawnLocation);
	}
	else if(currentMode == 1)
	{
		if(currentBox != None)
		{
			currentBox.bHidden = False;
			currentBox.SetCollision(True, True, True);
			currentBox.SetLocation(HitLocation);
						currentBox.bMovable=False;
			currentBox = None;
		}
		else
		{
			if(Box(Other) != None)
			{
				if(Box(Other).CreatedBy == DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName || DeusExPlayer(Owner).bAdmin)
				{
					currentBox.bMovable=True;
					currentBox = Box(Other);
					currentBox.SetCollision(False, False, False);
					currentBox.bHidden = True;
				}
			}
		}
	}
	else if(currentMode == 2)
	{
		if(Box(Other) != None)
		{
			if(Box(Other).CreatedBy == DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName || DeusExPlayer(Owner).bAdmin)
			{
			Box(Other).Destroy();
			}
		}
	}
	else if(currentMode == 3)
	{
		if(Box(Other) != None)
		{
			if(Box(Other).CreatedBy == DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName || DeusExPlayer(Owner).bAdmin)
			{
				if(currentBox != None)
				{
					currentBox.bHidden = False;
					currentBox.SetCollision(True, True, True);
				}
				currentBox = Box(Other);
				createSizeWindow();
			}
		}
	}
	else if(currentMode == 4)
	{
		if(Box(Other) != None)
		{
			if(Box(Other).CreatedBy == DeusExPlayer(Owner).PlayerReplicationInfo.PlayerName || DeusExPlayer(Owner).bAdmin)
			{
			Box(Other).Multiskins[0] = CurSkin;
			}
		}
	}
}

state NormalFire
{
Begin:
	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if (!bAutomatic)
		{
			bFiring = False;
			FinishAnim();
		}

		if (Owner != None)
		{
			if (Owner.IsA('DeusExPlayer'))
			{
				bFiring = False;


				// should we autoreload?
				if (DeusExPlayer(Owner).bAutoReload)
				{
					// auto switch ammo if we're out of ammo and
					// we're not using the primary ammo
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();
					ReloadAmmo();
				}
				else
				{
					if (bHasMuzzleFlash)
						EraseMuzzleFlashTexture();
					GotoState('Idle');
				}
			}
			else if (Owner.IsA('ScriptedPawn'))
			{
				bFiring = False;
				ReloadAmmo();
			}
		}
		else
		{
			if (bHasMuzzleFlash)
				EraseMuzzleFlashTexture();
			GotoState('Idle');
		}
	}
	if ( bAutomatic && (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient())))
		GotoState('Idle');

	Sleep(GetShotTime());
	if (bAutomatic)
	{
		GenerateBullet();	// In multiplayer bullets are generated by the client which will let the server know when
		Goto('Begin');
	}
	bFiring = False;
	FinishAnim();

	ReadyToFire();
Done:
	bFiring = False;
	Finish();
}

function PostBeginPlay()
{
Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
   {
      bWeaponStay = True;
      if (bNeedToSetMPPickupAmmo)
      {
         PickupAmmoCount = PickupAmmoCount * 3;
         bNeedToSetMPPickupAmmo = False;
      }
   }
}

defaultproperties
{
     cycleMessages(0)="Box Spawn Mode Activated"
     cycleMessages(1)="Box Move Mode Activated"
     cycleMessages(2)="Box Delete Mode Activated"
     cycleMessages(3)="Box Size Mode Activated"
     cycleMessages(4)="Box Skin Mode Activated"
     createSize=1.000000
     reloadTime=0.500000
     PickupAmmoCount=10
     bInstantHit=True
     bWeaponStay=True
     shakemag=0.000000
     InventoryGroup=56
     ItemName="Box Gun"
     beltDescription="BOX"
}
