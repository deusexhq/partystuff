//=============================================================================
// Researcher.
//=============================================================================
class Researcher extends DXHumanMilitary;

var float mySpeechTime;

function float ModifyDamage(int Damage, Pawn instigatedBy, Vector hitLocation,
                            Vector offset, Name damageType)
{
	if ( (damageType == 'Poison') || (damageType == 'PoisonEffect') || (damageType == 'PoisonGas')
           		|| (damageType == 'Radiation') || (damageType == 'Shocked') || (damageType == 'HalonGas') )
		return 0.0;
	else if ( (damageType == 'KnockedOut') || (damageType == 'Fell') )
		return 0.25;
        	else
		return Super.ModifyDamage(Damage, instigatedBy, hitLocation, offset, damageType);
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if ( !bCollideActors && !bBlockActors && !bBlockPlayers )
		return;
	else if ( CanShowPain() )
		TakeHit(hitPos);
	else
		GotoNextState();
}     

function UpdateFire()
{
}

function PlayOnFireSound()
{
	local DeusExPlayer dxPlayer;

	dxPlayer = DeusExPlayer(GetPlayerPawn());
	if ( dxPlayer != None )
		dxPlayer.StartAIBarkConversation(self, BM_Futz);
}

function PlayTargetAcquiredSound()
{
	local DeusExPlayer dxPlayer;

	dxPlayer = DeusExPlayer(GetPlayerPawn());
	if ( dxPlayer != None ) 
		dxPlayer.StartAIBarkConversation(self, BM_TargetAcquired);
}

function PlayAreaSecureSound()
{
	local DeusExPlayer dxPlayer;
	
	dxPlayer = DeusExPlayer(GetPlayerPawn());
	if ( dxPlayer != None ) 
		dxPlayer.StartAIBarkConversation(self, BM_AreaSecure);
}

function PlaySurpriseSound()
{
	local DeusExPlayer dxPlayer;

	dxPlayer = DeusExPlayer(GetPlayerPawn());
	if ( dxPlayer != None )
		dxPlayer.StartAIBarkConversation(self, BM_Surprise);
}

function CatchFire()
{
        	Super.CatchFire();
        	PlayOnFireSound();
}

function PlayAttackSounds()
{
        	local float rnd;

        	rnd = FRand();

        	if ( rnd < 0.33 )
             		PlayTargetAcquiredSound();
        	else if ( rnd < 0.67 )
             		PlaySurpriseSound();
        	else   
             		PlayAreaSecureSound();  
}     

function Tick(float deltaTime)
{
        	Super.Tick(deltaTime);
        	if (IsInState('Attacking'))
        	{
             		mySpeechTime += deltaTime;
             		if (mySpeechTime > 2.0)
             		{
                      		PlayAttackSounds(); 
	              		mySpeechTime = 0;             
	     	}
        	}
}

defaultproperties
{
			sScanning=sound'DeusExConAudioAIBarks.ConAudioAIBarks_97'
	sTargetAcquired=sound'DeusExConAudioAIBarks.ConAudioAIBarks_104'
	sTargetLost=sound'DeusExConAudioAIBarks.ConAudioAIBarks_105'
	sCriticalDamage=sound'DeusExConAudioAIBarks.ConAudioAIBarks_117'
	sAreaSecure=sound'DeusExConAudioAIBarks.ConAudioAIBarks_115'
	sBossArmourDown=sound'DeusExConAudioAIBarks.ConAudioAIBarks_89'
	sBossArmourBack=sound'DeusExConAudioAIBarks.ConAudioAIBarks_116'
	sMedkitUsed=sound'DeusExConAudioAIBarks.ConAudioAIBarks_117'
	sCallingBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_87'
	sRespondBackup=sound'DeusExConAudioAIBarks.ConAudioAIBarks_119'
	sHunting=sound'DeusExConAudioAIBarks.ConAudioAIBarks_92'
     BaseAccuracy=-0.250000
     CarcassType=Class'ResearcherCarcass'
     WalkingSpeed=0.213333
     bShowPain=False
     AvoidAccuracy=0.950000
     HarmAccuracy=0.950000
     CrouchRate=0.100000
     CloseCombatMult=1.000000
     SurprisePeriod=0.000000
     BaseAssHeight=-23.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponCrowbar')
     BurnPeriod=10.000000
     GroundSpeed=350.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.050000
     Health=500
     HealthHead=500
     HealthTorso=500
     HealthLegLeft=500
     HealthLegRight=500
     HealthArmLeft=500
     HealthArmRight=500
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ThugMaleTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ThugMaleTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.PaulDentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.LabCoatTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Researcher"
     BarkBindName="Researcher"
     FamiliarName="Researcher"
     UnfamiliarName="Researcher"
     bVisionImportant=False
}
