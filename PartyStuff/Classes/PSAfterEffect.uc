class PSAfterEffect extends Actor;

var bool bStartFade;

function AttachToPlayer(DeusExPlayer target)
{
	local int i;
	
	if(Target != None)
	{
		Style=STY_Translucent;
		Drawtype = target.DrawType;
		SetLocation(target.Location);
		Drawscale = target.Drawscale;
		Mesh = target.Mesh;
		SetRotation(target.Rotation);
		for(i=0;i<8;i++)
			Multiskins[i] = target.Multiskins[i];
		
		bStartFade=True;
	}
}

function Tick(float v)
{
	Scaleglow-=0.02;
	if(Scaleglow<0.01)
		Destroy();
	
}

defaultproperties
{
}
