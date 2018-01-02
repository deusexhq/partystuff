class Persist extends PGActors;

struct SavedX
{
var() config class<DeusExDecoration> ClassName;
var() config rotator ClassRotation;
var() config vector ClassLocation;
//var() config string ClassPhysics;
};
var() config SavedX ClassesX[250];

function Save()
{
local PSZoneInfo PSZ;
local DeusExDecoration deco;
local int j, c;

	for(j=0;j<250;j++)
	{
		ClassesX[j].ClassName = None;
	}
	Log("Config cleared of all entries.",'Persist');
	
	foreach AllActors(class'PSZoneInfo',PSZ)
	{
		if(PSZ.bEnableSaving)
		{
			foreach PSZ.ZoneActors(class'DeusExDecoration',deco)
			{
				if(!deco.isa('Lightswitch') || !deco.isa('Switch2'))
				{
					for(j=0;j<250;j++)
					{
						if(ClassesX[j].ClassName == None)
						{
							ClassesX[j].ClassName = deco.class;
							ClassesX[j].ClassRotation = deco.Rotation;
							ClassesX[j].ClassLocation = deco.Location;
							//ClassesX[j].ClassPhysics = deco.Physics;
							c++;
						}
					}
				}
			}
		}
	}
	SaveConfig();
	Log("Config entries added, total: "$c$".",'Persist');
	BroadcastMessage("Config entries added, total: "$c$".");
}

function Load()
{
local int j, c;
local DeusExDecoration sp;

		for(j=0;j<250;j++)
		{
			if(ClassesX[j].ClassName != None)
			{
				sp = Spawn(ClassesX[j].ClassName,,,ClassesX[j].ClassLocation);
				sp.SetRotation(ClassesX[j].ClassRotation);
				//sp.SetPhysics(name(ClassesX[j].ClassPhysics));
				c++;
			}
		}
	Log("Persisted actors spawned, total: "$c$".",'Persist');
	BroadcastMessage("Persisted actors spawned, total: "$c$".");
}

function Timer()
{
local PSZoneInfo PSZ;
local DeusExDecoration deco;
local int j, c;

	for(j=0;j<250;j++)
	{
		ClassesX[j].ClassName = None;
	}
	Log("Config cleared of all entries.",'Persist');
	
	foreach AllActors(class'PSZoneInfo',PSZ)
	{
		if(PSZ.bEnableSaving)
		{
			foreach PSZ.ZoneActors(class'DeusExDecoration',deco)
			{
				if(!deco.isa('Lightswitch') && !deco.isa('Switch2') && !deco.isa('Gem'))
				{
					for(j=0;j<250;j++)
					{
						if(ClassesX[j].ClassName == None)
						{
							ClassesX[j].ClassName = deco.class;
							ClassesX[j].ClassRotation = deco.Rotation;
							ClassesX[j].ClassLocation = deco.Location;
							//ClassesX[j].ClassPhysics = string(deco.Physics);
							c++;
						}
					}
				}
			}
		}
	}
	SaveConfig();
	Log("Config entries added, total: "$c$".",'Persist');
	BroadcastMessage("Map saved to server. ("$c$")");
}

defaultproperties
{
	bHidden=True
}
