local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;
local t = Def.ActorFrame {};

t[#t+1] =Def.ActorFrame{
	LoadActor(THEME:GetPathB("","doors open"));
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(y,SCREEN_CENTER_Y+20);
	LoadActor("ScreenStageInformation in/black_1")..{
		InitCommand=cmd(diffusealpha,0.3;x,SCREEN_LEFT+174);
		OnCommand=cmd(linear,0.099;zoomy,0;addx,-348);
	};
	LoadActor("ScreenStageInformation in/black_2")..{
		InitCommand=cmd(diffusealpha,0.3;x,SCREEN_RIGHT-136);
		OnCommand=cmd(linear,0.099;zoomy,0;addx,272);
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y-124);
	end;
	LoadActor("ScreenStageInformation in/banner_stage")..{
		InitCommand=cmd(CenterX);
		OnCommand=cmd(linear,0.099;zoomy,0);
	};
};

--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';CenterX;y,SCREEN_CENTER_Y-130;linear,0.099;zoomy,0);
	Def.Sprite {
		SetCommand=function(self)
			local entity = GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if entity:HasBanner() then
				self:Load(entity:GetBannerPath());
				self:setsize(256,80);
			else
				self:Load(THEME:GetPathG("","Common fallback banner"));
				self:setsize(256,80);
			end;
		end;
	};
};

t[#t+1] = LoadActor("ScreenStageInformation in/bottom_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-27);
	OnCommand=cmd(linear,0.198;addy,54;sleep,0;diffusealpha,0);
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX;y,SCREEN_TOP+52);
	OnCommand=cmd(linear,0.198;addy,-104;sleep,0;diffusealpha,0);
	LoadActor(THEME:GetPathG("","ScreenWithMenuElements header/centerbase"));
	LoadActor(THEME:GetPathG("","ScreenWithMenuElements header/Stage"))..{
		InitCommand=cmd(valign,1;);
	}
};

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	OnCommand=function(self)
		if GAMESTATE:GetPlayMode() == 'PlayMode_Regular' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle' or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			self:Load(THEME:GetPathG("_StageInfo/ScreenStageInformation", "Stage " .. ToEnumShortString(sStage) ));
		elseif GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:Load(THEME:GetPathG("_StageInfo/ScreenStageInformation", "Stage oni"));
		elseif GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
			self:Load(THEME:GetPathG("_StageInfo/ScreenStageInformation", "Stage Nonstop"));
		elseif (GAMESTATE:Env()).EndlessState then
			self:Load(THEME:GetPathG("_StageInfo/ScreenStageInformation", "Stage endless"));
		end;
	self:linear(0.1):diffusealpha(0);
	end;
	};
};

return t;
