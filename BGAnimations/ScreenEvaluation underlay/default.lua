local stageStats = STATSMAN:GetCurStageStats()
local tnsToColor = {
    TapNoteScore_W3=color "#02EC20",
    TapNoteScore_W2=color "#FDF908",
    TapNoteScore_W1=color "#FFF2D9"
}

local playerXPositions = {
    PlayerNumber_P1=SCREEN_CENTER_X-226,
    PlayerNumber_P2=SCREEN_CENTER_X+335
}

local playerXGradePositions = {
    PlayerNumber_P1=SCREEN_CENTER_X-233,
    PlayerNumber_P2=SCREEN_CENTER_X+230
}

local actors = Def.ActorFrame{}

for _, player in pairs(GAMESTATE:GetEnabledPlayers()) do
    local pss = stageStats:GetPlayerStageStats(player)
    assert(pss, "No PlayerStageStats for "..player..". This might actually be a mistake on your part, Jack.")
    --this whole block is setting up for us to iterate from TNS_W1 down to TNS_Miss
    local revTns = TapNoteScore:Reverse()
    local bestTns = revTns.TapNoteScore_W1
    local worstTns = revTns.TapNoteScore_Miss
    for idx=bestTns, worstTns, -1 do
        local curTns = TapNoteScore[idx]
        if tnsToColor[curTns] and pss:FullComboOfScore(curTns) then
            table.insert(actors,Def.ActorFrame{
                LoadActor("fullcomboring")..{
                    InitCommand=function(self) self:x(playerXPositions[player]):y(SCREEN_CENTER_Y-105):rotationx(75):zoom(0) end;
                    OnCommand=function(self) self:sleep(0.6):linear(0.1):zoom(0.6):spin():effectmagnitude(0,0,-150) end;
                    OffCommand=function(self) self:linear(0.2):zoom(0) end
                },
                LoadActor("fullcomboring")..{
                    InitCommand=function(self) self:x(playerXPositions[player]):y(SCREEN_CENTER_Y-105):rotationy(-20):rotationx(75):zoom(0) end;
                    OnCommand=function(self) self:sleep(0.6):linear(0.1):zoom(0.6):spin():effectmagnitude(0,0,-150) end;
                    OffCommand=function(self) self:linear(0.2):zoom(0) end
                },
            })
            break
        end
    end
end

return actors
