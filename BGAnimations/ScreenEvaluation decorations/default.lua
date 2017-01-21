local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay");

t[#t+1] = LoadActor(THEME:GetPathG("","_footer/skip"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

-- judge labels
t[#t+1] = LoadActor("labels")..{
	InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+32;zoomy,0);
	OnCommand=cmd(linear,0.3;zoomy,1);
	OffCommand=cmd(sleep,0.2;linear,0.2;zoomy,0);
};

t[#t+1] = LoadActor("frame left")..{
	InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_TOP+128);
	OnCommand=cmd(diffusealpha,0.3;addx,-348;zoomy,0;sleep,0.2;linear,0.2;zoomy,1;addx,348);
	OffCommand=cmd(linear,0.2;zoomy,0;addx,-348);
};

t[#t+1] = LoadActor("P1")..{
	BeginCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) then self:visible(true) else self:visible(false) end;
	end;
	InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y+60);
	OnCommand=cmd(draworder,9;addx,-250;sleep,0.2;linear,0.2;addx,250);
	OffCommand=cmd(linear,0.2;addx,-250);
};

t[#t+1] = LoadActor("P2")..{
	BeginCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) then self:visible(true) else self:visible(false) end;
	end;
	InitCommand=cmd(halign,1;x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+60);
	OnCommand=cmd(draworder,9;addx,250;sleep,0.2;linear,0.2;addx,-250);
	OffCommand=cmd(linear,0.2;addx,250);
};

t[#t+1] = LoadActor("frame right")..{
	InitCommand=cmd(halign,1;x,SCREEN_RIGHT;y,SCREEN_TOP+128);
	OnCommand=cmd(diffusealpha,0.3;addx,272;zoomy,0;sleep,0.2;linear,0.2;zoomy,1;addx,-272);
	OffCommand=cmd(linear,0.2;zoomy,0;addx,272);
};

-- difficulty display
if ShowStandardDecoration("DifficultyIcon") then
	if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
		-- in rave mode, we always have two players.
	else
		-- otherwise, we only want the human players
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local diffIcon = LoadActor(THEME:GetPathG(Var "LoadingScreen", "DifficultyIcon"), pn)
			t[#t+1] = StandardDecorationFromTable("DifficultyIcon" .. ToEnumShortString(pn), diffIcon);
		end
	end
end

t[#t+1] = LoadActor("../grade")..{
	OnCommand=cmd(play);
};

for pn in ivalues(PlayerNumber) do
	local MetricsName = "MachineRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end

for pn in ivalues(PlayerNumber) do
	local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
		InitCommand=cmd(halign,0;player,PLAYER_1;x,SCREEN_LEFT+110;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+180):zoomy(0):linear(0.2):zoomy(1)
		end;
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
	LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
		InitCommand=cmd(halign,1;player,PLAYER_2;x,SCREEN_RIGHT-110;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+180):zoomy(0):linear(0.2):zoomy(1)
		end;
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
};

t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2();
	InitCommand=cmd(draworder,105);
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra1" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		OnCommand=cmd(play);
	};
};

local stageXPos = {
	P1 = -280,
	P2 = 280
}

if GAMESTATE:IsCourseMode() then
	local function FindText(pss)
		if pss:GetFailed() then
			return string.format("%02d STAGE",pss:GetSongsPassed())
		else
			return "CLEAR"
		end
	end
	for _, pn in pairs(GAMESTATE:GetHumanPlayers()) do
		local shortPn = ToEnumShortString(pn)
		t[#t+1] = Def.BitmapText{
			Font="_handelgothic bt 20px";
			InitCommand=cmd(x,SCREEN_CENTER_X+stageXPos[shortPn];y,SCREEN_CENTER_Y+20);
			OnCommand=function(s)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local darkLength = (#(tostring(pss:GetSongsPassed()))) == 1 and 1 or 0
				s:diffusealpha(0)
				:settext(FindText(pss))
				:AddAttribute(0,{Length=darkLength, Diffuse=color "#777777"})
				:sleep(0.8):diffusealpha(1)
			end;
			OffCommand=function(s) s:linear(1):diffusealpha(0) end;
		};
	end
end

return t
