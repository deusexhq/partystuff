class FLBasketball4Player extends DeusExDecoration;

event BaseChange()
{
	local FLBasketball AdvB;
	if (bWasCarried)
	{
		AdvB = Spawn(Class'FLBasketball',Owner,,Location,Rotation);
		AdvB.Velocity = Velocity + 0.7 * Owner.Velocity;
		AdvB.SetTimer(0.5,False);
		Destroy();
	}
}

defaultproperties
{
     bInvincible=True
     ItemName="Basketball"
     Mesh=LodMesh'PGAssets.FLBasketball'
     DrawScale=0.710000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bBounce=True
     Mass=8.000000
     Buoyancy=10.000000
}
