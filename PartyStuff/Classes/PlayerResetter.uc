class PlayerResetter extends PGActors;

var DeusExPlayer Target;
var string myToDo;

function Timer()
{
	if(myToDo == "unfreeze")
	{
		Target.bMovable=True;
		Target.bmeshEnviroMap=False;
		Target.Texture = Target.Default.Texture;
		Target.bBehindView=False;
	}
	if(myToDo == "unspeed")
	{
		Human(Target).mpgroundspeed = Human(target).default.mpgroundspeed;
	}
}

defaultproperties
{
bHidden=True
}
