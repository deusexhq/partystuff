//=============================================================================
// BoxSizeWindow.
//=============================================================================
class PSKM expands MenuUIScreenWindow;

var MenuUIActionButtonWindow SendButton, exitButton;
var MenuUIEditWindow editCommand, editPassword;
var MenuUIHeaderWindow winText;
var localized string exitbuttontext, passwordlabel, sendbuttontext, commandlabel;
var DeusExPlayer _windowOwner;
var PSKeypad Ac;
var PSKR Mastah;
var MenuUIMessageBoxWindow AlertWin;

event InitWindow()
{
   local Window W;

   Super.InitWindow();
   CreateTextWindow();
   SendButton = winButtonBar.AddButton(sendButtonText, HALIGN_Right);
   exitButton = winButtonBar.AddButton(exitButtonText, HALIGN_Right);
  
//	CreateMenuLabel(10, 55, CommandLabel, winClient);
	CreateMenuLabel(10, 22, PasswordLabel, winClient);
	editPassword = CreateMenuEditWindow(105, 20, 143, 20, winClient);
	//EditCommand = CreateMenuEditWindow(105, 54, 143, 20, winClient);
	//EditCommand.SetMaxSize(70); //cap said to fit the window as best as possible until the word wrap can be figured out..
	
   winClient.SetBackground(Texture'DeusExUI.MaskTexture');
   winClient.SetBackgroundStyle(DSTY_Modulated);

   W = winClient.NewChild(Class'Window');
   W.SetSize(ClientWidth, ClientHeight);
   W.SetBackground(Texture'DeusExUI.MaskTexture');
   W.SetBackgroundStyle(DSTY_Modulated);
   W.Lower();
	
   SetTitle("Password Entry");
}

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;
	local string GetCom, GetPass;
	bHandled = True;

	Super.ButtonActivated(buttonPressed);

	switch( buttonPressed )
	{
		case SendButton:
			//GetCom = editCommand.GetText();
			GetPass = editPassword.GetText();
				if(Mastah.ChkPass(_windowOwner, getPass))
				{
					//_windowOwner.ClientMessage("Sending login"@_windowowner.playerreplicationinfo.playername@getuser@getpass);
					root.PopWindow();
					bHandled = True;
				}
		//	}
			break;
			
		case exitButton:
			root.PopWindow();
			bHandled = True;
			break;

		default:
			bHandled = False;
			break;
	}

	return bHandled;
}

function CreateTextWindow()
{
	winText = CreateMenuHeader(21, 13, "", winClient);
	winText.SetTextAlignments(HALIGN_Center, VALIGN_Center);
	winText.SetFont(Font'FontMenuHeaders_DS');
	winText.SetWindowAlignments(HALIGN_Full, VALIGN_Full, 20, 14);
}

function SetMessageText( String msgText )
{
	winText.SetText(msgText);

	AskParentForReconfigure();
}

event bool VirtualKeyPressed(EInputKey key, bool bRepeat)
{
	local bool bHandled;

	switch( key )
	{
		case IK_Enter:
				if(Mastah.ChkPass(_windowOwner, editPassword.GetText()))
				{
					root.PopWindow();
				}
				bHandled = True;
			break;
	}

	return bHandled;
}

event bool RawKeyPressed(EInputKey key, EInputState iState, bool bRepeat)
{
	if (key == IK_Enter)// &&//(iState == IST_Release))
	{
				if(Mastah.ChkPass(_windowOwner, editPassword.GetText()))
				{
					root.PopWindow();
				}
		return True;
	}
	else
	{
		return false;
	}
}


defaultproperties
{
	exitbuttontext="Exit"
	passwordlabel="Password"
	sendbuttontext="Send <Enter>"
	commandlabel="Command"
     ClientWidth=300//400
     ClientHeight=75//250
   //  clientTextures(0)=Texture'DeusExUI.UserInterface.MenuMessageBoxBackground_1'
    // clientTextures(1)=Texture'DeusExUI.UserInterface.MenuMessageBoxBackground_2'
     textureRows=3
     textureCols=2
     bActionButtonBarActive=True
     bUsesHelpWindow=False
    // winShadowClass=Class'DeusEx.MenuUIMessageBoxShadowWindow'
}
