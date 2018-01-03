//=============================================================================
//.
//=============================================================================
class eReplica extends DXEnemy;

var string ReplicatedPlayerName;
var DeusExPlayer RList[18];

function Bool HasTwoHandedWeapon()
{
	return False;
}

function Carcass SpawnCarcass()
{	
	Destroy();
	return None;
}

defaultproperties
{
     scoreCredits=300
     WalkingSpeed=0.320000
     bImportant=True
	 bMeshEnviroMap=True
     BaseAssHeight=-18.000000
     walkAnimMult=0.650000
     GroundSpeed=120.000000
     BaseEyeHeight=38.000000
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     Texture=FireTexture'Effects.Electricity.Nano_SFX_A'
     CollisionRadius=20.000000
     CollisionHeight=43.000000
     BindName="Replica"
     FamiliarName="Firewall Replica Soldier"
     UnfamiliarName="Firewall Replica Soldier"
}
