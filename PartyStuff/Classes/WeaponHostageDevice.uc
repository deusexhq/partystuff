class WeaponHostageDevice extends WeaponStealthPistol;

var int currentMode;
var string cycleMessages[6];
var Pawn hostage;

replication
{
     reliable if (Role == ROLE_Authority)
        currentMode, hostage;
}

function string GetDisplayString(Pawn P)
{
	if(P.isA('DeusExPlayer'))
		return DeusExPlayer(p).PlayerReplicationInfo.PlayerName;
	else if(P.isA('ScriptedPawn'))
		return ScriptedPawn(P).FamiliarName;
}

function GiveTo( pawn Other )
{
    super.Giveto(Other);
    super.GiveAmmo(Other);
	hostage = none;
	currentMode = 0;
	Other.ClientMessage("|P3Press Ammochange to cycle through the modes");

}

simulated function cycleammo()
{
	if(Hostage != None)
	{
		currentMode++;
		if(currentMode > 4)
		{
			currentMode = 0;
		}
		DeusExPlayer(Owner).ClientMessage(cycleMessages[currentMode]);	
	}
	else
	{
	DeusExPlayer(Owner).ClientMessage("Features unavailable while no hostage is hooked.");
	currentMode = 0;
	}
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{

    local DeusExWeapon W;
    local Pawn P;
local vector hostageLocation; 
local string checkedhostage;

	if(currentMode == 0)
	{
		//Hooking
		Other = Pawn(Other);
				if(hostage != none)
				{
					if(Other != None)
					{
							foreach allactors(class'Pawn',P)
							{
								if(P == hostage)
								{
								checkedhostage = GetDisplayString(P);
								DeusExPlayer(Owner).ClientMessage("|P3Current hostage will be released: "$checkedhostage,'TeamSay');
								}
							}
					}
				}
				
			if(Other != None)
			{
				if(Other.isA('DXScriptedPawn'))
				{
					if(DXHumanMilitary(Other).bSpecial)
					{
						DeusExPlayer(Owner).ClientMessage("|P2You can not take this person as a hostage. [Special]");
						return;					
					}

				}
				if(Other.isA('DeusExPlayer'))
				{
					if(DeusExPlayer(Other).bAdmin)
					{
						DeusExPlayer(Owner).ClientMessage("|P2You can not take this person as a hostage. [Admin Protection]");
						return;					
					}

				}
				checkedhostage = GetDisplayString(pawn(other));
				DeusExPlayer(Owner).ClientMessage("|P3Hostage Hooked: "$checkedhostage,'TeamSay');
				hostage = pawn(Other);
				SpawnSphere(Other.Location);
				SpawnSphere(Owner.Location);
			}
	}
	else if(currentMode == 1)
	{
		//Releasing
		if(hostage != none)
		{
			foreach allactors(class'Pawn',P)
			{
				if(P == hostage)
				{
				SpawnSphere(P.Location);
				SpawnSphere(Owner.Location);
				checkedhostage = GetDisplayString(p);
				DeusExPlayer(Owner).ClientMessage("|P3Hostage Unhooked: "$checkedhostage,'TeamSay');
				hostage = None;
				}
			}	
		}
		else
		{
		DeusExPlayer(Owner).ClientMessage("|P3There is no hostage hooked!",'TeamSay');
		currentMode = 0;
		}
		
	}
	else if(currentMode == 2)
	{
		//Teleporting to
		if(hostage != none)
		{
			foreach allactors(class'Pawn',P)
			{
				if(P == hostage)
				{
				
				checkedhostage = GetDisplayString(p);
				DeusExPlayer(Owner).ClientMessage("|P3Hostage Located: "$checkedhostage);
				Owner.SetLocation(P.location+vect(50,0,0));
				SpawnSphere(P.Location);
				SpawnSphere(Owner.Location);
				}
			}	
		}
		else
		{
		DeusExPlayer(Owner).ClientMessage("|P3There is no hostage hooked!",'TeamSay');
		currentMode = 0;
		}
	}
	else if(currentMode == 3)
	{
		//Summoning
		if(hostage != none)
		{
			foreach allactors(class'Pawn',P)
			{
				if(P == hostage)
				{
				checkedhostage = GetDisplayString(p);
				DeusExPlayer(Owner).ClientMessage("|P3Hostage Summoned: "$checkedhostage);
				P.SetLocation(Owner.location+vect(50,0,0));
				SpawnSphere(P.Location);
				SpawnSphere(Owner.Location);
				}
			}	
		}
		else
		{
		DeusExPlayer(Owner).ClientMessage("|P3There is no hostage hooked!",'TeamSay');
		currentMode = 0;
		}
	}
	else if(currentMode == 4)
	{
		//Killing
		if(hostage != none)
		{
			foreach allactors(class'Pawn',P)
			{
				if(P == hostage)
				{
				checkedhostage = GetDisplayString(p);
				DeusExPlayer(Owner).ClientMessage("|P3Hostage Killed: "$checkedhostage);
				DeusExPlayer(P).ReducedDamageType = '';
				ScriptedPawn(P).bInvincible=False;
				SpawnExplosion(P.Location);
				P.setPhysics(PHYS_Falling);
				P.Velocity = vect(0,0,512);
				P.TakeDamage(5000,none,vect(0,0,7),vect(0,0,0),'Exploded');
					if(P.isa('ScriptedPawn'))
					{
						DeusExPlayer(Owner).ClientMessage("|P3Hostage is an scriptedPawn, and permenantly dead. Hostage Device no longer hooked.");
						hostage = none;
						currentMode = 0;
					}
				}
			}	
		}
		else
		{
		DeusExPlayer(Owner).ClientMessage("|P3There is no hostage hooked!",'TeamSay');
		currentMode = 0;
		}
	}
	else if(currentMode == 5)
	{
		//Viewing
		/*if(hostage != "")
		{
			foreach allactors(class'Pawn',P)
			{
				if(P == hostage)
				{
					if(bViewing)
				checkedhostage = GetDisplayString(p);
				DeusExPlayer(Owner).ClientMessage("|P3Hostage Viewed: "$checkedhostage);
				}
			}	
		}
		else
		{
		DeusExPlayer(Owner).ClientMessage("|P3There is no hostage hooked!",'TeamSay');
		currentMode = 0;
		}*/
	}
}

function SpawnExplosion(vector Loc)
{
    spawn(class'ShockRing',,,Loc,rot(16384,0,0));
    spawn(class'ShockRing',,,Loc,rot(0,16384,0));
    spawn(class'ShockRing',,,Loc,rot(0,0,16384));
	spawn(class'SphereEffect',,,Loc,rot(16384,0,0));
}

function SpawnSphere(vector Loc)
{
local SphereEffect S;
	s = spawn(class'SphereEffect',,,Loc,rot(16384,0,0));
}


simulated function PreBeginPlay()
{
    return;
}

state NormalFire //Bowens Infinite Firing
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
         GenerateBullet();       // In multiplayer bullets are generated by the client which will let the server know when 
         Goto('Begin'); 
      } 
      bFiring = False; 
      FinishAnim(); 
    
   /*      // if ReloadCount is 0 and we're not hand to hand, then this is a 
      // single-use weapon so destroy it after firing once 
      if ((ReloadCount == 0) && !bHandToHand) 
      { 
         if (DeusExPlayer(Owner) != None) 
            DeusExPlayer(Owner).RemoveItemFromSlot(Self);   // remove it from the inventory grid 
         Destroy(); 
      } 
      */              // Do I REALLY need all that crap JUST for infinite ammo? 
      ReadyToFire(); 
   Done: 
      bFiring = False; 
      Finish(); 
} 

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

//-----END-CLASS----------

defaultproperties
{
     cycleMessages(0)="Take Hostage"
     cycleMessages(1)="Release Hostage"
     cycleMessages(2)="Teleport to Hostage"
     cycleMessages(3)="Summon Hostage"
     cycleMessages(4)="Kill Hostage"
     cycleMessages(5)="Cheat View Hostage"
     ShotTime=0.100000
     HitDamage=0
     BaseAccuracy=0.000000
     ReloadCount=0
     PickupAmmoCount=0
     FireSound=Sound'DeusExSounds.Generic.Beep1'
     InventoryGroup=201
     ItemName="Hostage Device"
     PickupViewMesh=LodMesh'DeusExItems.Multitool'
     ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
     largeIcon=None
     Description="An interesting device..."
     beltDescription="HOSTAGE"
}
