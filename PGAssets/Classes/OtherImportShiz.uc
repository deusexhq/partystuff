///////////////////////////////////////////////////
//
///////////////////////////////////////////////////

class OtherImportShiz extends Actor;

#exec TEXTURE IMPORT NAME=DoritosTex1 FILE=Textures\DoritosTex1.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=DoritosBelt FILE=Textures\BeltDoritos.bmp GROUP=Skins FLAGS=2


#exec TEXTURE IMPORT NAME=SandwichTex1 FILE=Textures\SandwichTex1.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=SandwichTex2 FILE=Textures\SandwichTex2.bmp GROUP=Skins

#exec TEXTURE IMPORT NAME=RedBullTex1 FILE=Textures\RedBullTex1.bmp GROUP=Skins

#exec TEXTURE IMPORT NAME=SaladTex1 FILE=Textures\SaladTex1.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=SaladBelt FILE=Textures\BeltSalad.bmp GROUP=Skins FLAGS=2

#exec TEXTURE IMPORT NAME=SandwichBelt FILE=Textures\BeltSandwich.bmp GROUP=Skins FLAGS=2
#exec mesh import mesh=sandwich anivfile=Models\sandwich_a.3d datafile=Models\sandwich_d.3d x=0 y=0 z=0
#exec mesh origin mesh=sandwich x=0 y=0 z=0
#exec mesh sequence mesh=sandwich seq=All startframe=0 numframes=1

#exec meshmap new meshmap=sandwich mesh=sandwich
#exec meshmap scale meshmap=sandwich x=0.07 y=0.07 z=0.07
//#exec meshmap scale meshmap=sandwich x=0.01563 y=0.01563 z=0.03125

#exec TEXTURE IMPORT NAME=CheeseTex1 FILE=Textures\CheeseTex1.bmp GROUP=Skins

#exec TEXTURE IMPORT NAME=BLTTex1 FILE=Textures\BLTTex1.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=KebabBelt FILE=Textures\BeltKebab.bmp GROUP=Skins FLAGS=2


#exec mesh import mesh=kebab anivfile=Models\kebab_a.3d datafile=Models\kebab_d.3d x=0 y=0 z=0
#exec mesh origin mesh=kebab x=0 y=0 z=0
#exec mesh sequence mesh=kebab seq=All startframe=0 numframes=1

#exec meshmap new meshmap=kebab mesh=kebab
#exec meshmap scale meshmap=kebab x=1 y=1 z=1

#exec TEXTURE IMPORT NAME=GalaxyTex1 FILE=Textures\GalaxyTex1.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=GalaxyBelt FILE=Textures\BeltGalaxy.bmp GROUP=Skins FLAGS=2

#exec TEXTURE IMPORT NAME=GalaxyTex2 FILE=Textures\GalaxyTex2.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=BeltIconChoc2 FILE=Textures\BeltIconChoc2.bmp GROUP=Skins FLAGS=2


#exec TEXTURE IMPORT NAME=GalaxyTex3 FILE=Textures\GalaxyTex3.bmp GROUP=Skins
#exec TEXTURE IMPORT NAME=BeltIconChoc3 FILE=Textures\BeltIconChoc3.bmp GROUP=Skins FLAGS=2
