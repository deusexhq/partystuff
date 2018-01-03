class SkullBallMP4Player2 extends DeusExDecoration;

event BaseChange()
{
	local SkullballMP2 AdvB;
	if (bWasCarried)
	{
		AdvB = Spawn(Class'SkullBallMP2',Owner,,Location,Rotation);
		AdvB.Velocity = Velocity + 0.7 * Owner.Velocity;
		Destroy();
	}
}

defaultproperties
{
     bInvincible=True
     ItemName="Skull"
     Mesh=LodMesh'DeusExDeco.BoneSkull'
     DrawScale=0.600000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bBounce=True
     Mass=8.000000
     Buoyancy=10.000000
}
