class FreezeGrenade expands ThrownProjectile;

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
local DeusExPlayer player;
local ScriptedPawn pwn;
local DeusExDecoration DXP;
local PlayerResetter PR;
		local FrozenPerson fperson;
local DeusExCarcass DXC;
local int i;
	//bmeshenviromap and texture ice
	foreach VisibleActors(class'DeusExPlayer',player,768)
	{
		PR = Spawn(class'PlayerResetter');
		PR.Target = player;
		PR.SetTimer(15,False);
		PR.myTodo = "unfreeze";
		Player.bMeshEnviroMap=True;
		Player.Texture = Texture'IceTex';
		player.bMovable=False;
		player.bBehindView=True;
	}
	/*foreach VisibleActors(class'ScriptedPawn',pwn,768)
	{
			fperson = Spawn(class'FrozenPerson',,,pwn.Location);
			fperson.SetCollisionSize(pwn.CollisionRadius,pwn.CollisionHeight);
			fperson.Texture = pwn.Texture;
			fperson.Mesh=pwn.Mesh;
			fperson.Mass=pwn.Mass;
			for (i=0;i<8;i++)
			{
				if ((pwn.MultiSkins[i]==Texture'DeusExItems.Skins.GrayMaskTex')
					|| (pwn.MultiSkins[i]==Texture'DeusExItems.Skins.PinkMaskTex')
						|| (pwn.MultiSkins[i]==Texture'DeusExItems.Skins.BlackMaskTex'))
				{
					fperson.MultiSkins[i]=pwn.MultiSkins[i];
				}
				else
					fperson.MultiSkins[i] = Texture'IceTex';
			}
			fperson.setRotation(pwn.Rotation);
			pwn.Destroy();			
	}
	foreach VisibleActors(class'DeusExDecoration',dxp,768)
	{
			fperson = Spawn(class'FrozenPerson',,,dxp.Location);
			fperson.SetCollisionSize(dxp.CollisionRadius,dxp.CollisionHeight);
			fperson.Texture = dxp.Texture;
			fperson.Mesh=dxp.Mesh;
			fperson.Mass=dxp.Mass;
			for (i=0;i<8;i++)
			{
				if ((dxp.MultiSkins[i]==Texture'DeusExItems.Skins.GrayMaskTex')
					|| (dxp.MultiSkins[i]==Texture'DeusExItems.Skins.PinkMaskTex')
						|| (dxp.MultiSkins[i]==Texture'DeusExItems.Skins.BlackMaskTex'))
				{
					fperson.MultiSkins[i]=dxp.MultiSkins[i];
				}
				else
					fperson.MultiSkins[i] = Texture'IceTex';
			}
			fperson.setRotation(dxp.Rotation);
			dxp.Destroy();	
	}
	foreach VisibleActors(class'DeusExCarcass',DXC,768)
	{
			fperson = Spawn(class'FrozenPerson',,,DXC.Location);
			fperson.SetCollisionSize(DXC.CollisionRadius,DXC.CollisionHeight);
			fperson.Texture = DXC.Texture;
			fperson.Mesh=DXC.Mesh;
			fperson.Mass=DXC.Mass;
			for (i=0;i<8;i++)
			{
				if ((DXC.MultiSkins[i]==Texture'DeusExItems.Skins.GrayMaskTex')
					|| (DXC.MultiSkins[i]==Texture'DeusExItems.Skins.PinkMaskTex')
						|| (DXC.MultiSkins[i]==Texture'DeusExItems.Skins.BlackMaskTex'))
				{
					fperson.MultiSkins[i]=DXC.MultiSkins[i];
				}
				else
					fperson.MultiSkins[i] = Texture'IceTex';
			}
			fperson.setRotation(DXC.Rotation);
			DXC.Destroy();	
	}*/
}

defaultproperties
{
     fuseLength=3.000000
     proxRadius=128.000000
     spawnWeaponClass=Class'PartyStuff.WeaponFreezeGrenade'
     spawnAmmoClass=Class'PartyStuff.AmmoFreezeGrenade'
     ItemName="Icer Grenade"
     ItemArticle="an"
     speed=1500.000000
     ImpactSound=Sound'DeusExSounds.Generic.SmallExplosion2'
     Mesh=LodMesh'DeusExItems.EMPGrenadePickup'
}
