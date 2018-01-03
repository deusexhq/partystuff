//=============================================================================
// HowardStrong.
//=============================================================================
class eHoward extends DxEnemy;

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
     CarcassType=Class'DeusEx.HowardStrongCarcass'
     WalkingSpeed=0.296000
     bImportant=True
     walkAnimMult=0.750000
     GroundSpeed=200.000000
          InitialInventory(0)=(Inventory=Class'DeusEx.WeaponSawedOffShotgun')
     InitialInventory(1)=(Inventory=Class'DeusEx.AmmoShell',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCrowbar')
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.HowardStrongTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.HowardStrongTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.HowardStrongTex0'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.HowardStrongTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex2'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="eHoward"
     FamiliarName="Howard Strong"
     UnfamiliarName="Howard Strong"
}
