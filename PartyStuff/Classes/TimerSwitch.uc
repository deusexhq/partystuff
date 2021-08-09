class TimerSwitch extends Switch1;

var() string myName;
var() bool bIsStart;
var() bool bIsEnd;

var bool bTimerOn;
var int Count;
var bool bStarter;
var DeusExPlayer myPlayer;


function Timer(){
    local TimerSwitch ts;
    
    Count++;
    if(Count % 5 == 0 && bStarter) myPlayer.ClientMessage(myName$": "$Count);
    if(bTimerOn) SetTimer(1, false);
}

function Frob(Actor Frobber, Inventory frobWith){
    local TimerSwitch ts;
    if(bTimerOn){
        if(bIsEnd){
            BroadcastMessage("Timer "$myName$" ("$myPlayer.PlayerReplicationInfo.PlayerName$") ended at "$Count$" seconds!");
            bTimerOn = False;
            bStarter = False;
            myPlayer = None;
            foreach AllActors(class'TimerSwitch', ts){
                if(ts != self && ts.myName == myName) {ts.bTimerOn = False; ts.bStarter = False;}
            }  
        } else DeusExPlayer(Frobber).ClientMessage("This is not available right now.");
    } else {
        if(bIsStart){
            Count = 0;
            bStarter = True;
            myPlayer = DeusExPlayer(frobber);
            bTimerOn = True;
            SetTimer(1, false);
            foreach AllActors(class'TimerSwitch', ts){
                if(ts != self && ts.myName == myName) {ts.count = 0; ts.myPlayer = DeusExPlayer(frobber); ts.SetTimer(1, false); ts.bTimerOn = True;}
            }  
            myPlayer.ClientMessage(myName$": BEGIN!");
        } else DeusExPlayer(Frobber).ClientMessage("This is not available right now.");
    }
}

defaultproperties
{
    ItemName="Timer Button"
}
