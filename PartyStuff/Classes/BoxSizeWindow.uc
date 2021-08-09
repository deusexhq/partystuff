//=============================================================================
// BoxSizeWindow.
//=============================================================================
class BoxSizeWindow expands MenuUIWindow;

var MenuUIActionButtonWindow okButton;
var MenuUIActionButtonWindow defaultButton;
var MenuUIActionButtonWindow exitButton;
var MenuUIEditWindow sizeWindow;
var MenuUIHeaderWindow winText;
var localized string okButtonText;
var localized string defaultButtonText;
var localized string exitButtonText;
var WeaponBoxGun _windowOwner;
var float _boxSize;

event InitWindow()
{
   local Window W;

   Super.InitWindow();

   winClient.SetBackground(Texture'DeusExUI.MaskTexture');
   winClient.SetBackgroundStyle(DSTY_Modulated);

   W = winClient.NewChild(Class'Window');
   W.SetSize(ClientWidth, ClientHeight);
   W.SetBackground(Texture'DeusExUI.MaskTexture');
   W.SetBackgroundStyle(DSTY_Modulated);
   W.Lower();

   sizeWindow = CreateMenuEditWindow(60, 45, 70, 30, winClient);

   okButton = winButtonBar.AddButton(okButtonText, HALIGN_Right);
   exitButton = winButtonBar.AddButton(exitButtonText, HALIGN_Left);
   defaultButton = winButtonBar.AddButton(defaultButtonText, HALIGN_Center);

   sizeWindow.setText("1.00000");
   SetTitle("Box Size");
}

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	bHandled = True;

	Super.ButtonActivated(buttonPressed);

	switch( buttonPressed )
	{
		case okButton:
			// Do stuff
			if(float(sizeWindow.GetText()) > 5)
				sizeWindow.setText("5.00000");

			_windowOwner.setSize(float(sizeWindow.GetText()), 1);
			//root.PopWindow();
			bHandled = True;
			break;

		case defaultButton:
			// Do stuff
			if(float(sizeWindow.GetText()) > 5)
				sizeWindow.setText("5.00000");

			_windowOwner.setSize(float(sizeWindow.GetText()), 2);
			//root.PopWindow();
			bHandled = True;
			break;

		case exitButton:
			// Do stuff
			root.PopWindow();
			bHandled = True;
			break;

		default:
			bHandled = False;
			break;
	}

	return bHandled;
}

defaultproperties
{
     okButtonText="Ok"
     defaultButtonText="Set as Default"
     exitbuttontext="Done"
     ClientWidth=350
     ClientHeight=85
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuMessageBoxBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuMessageBoxBackground_2'
     textureRows=1
     textureCols=2
     bActionButtonBarActive=True
     bUsesHelpWindow=False
     winShadowClass=Class'DeusEx.MenuUIMessageBoxShadowWindow'
}
