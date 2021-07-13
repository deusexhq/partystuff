class SurfRocket extends Rocket;

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);
	Owner.SetLocation(Location);
}

defaultproperties
{
    ItemName="bombing"
    ItemArticle="suicide"
}
