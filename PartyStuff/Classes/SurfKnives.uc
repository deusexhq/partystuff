class SurfKnives extends Shuriken;

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);
	Owner.SetLocation(Location);
}

defaultproperties
{
     ItemName="a"
     ItemArticle="surf knife"
}
