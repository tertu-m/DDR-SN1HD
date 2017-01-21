local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")
t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")
t[#t+1] = StandardDecorationFromFileOptional("SortDisplay","SortDisplay")
t[#t+1] = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(setsize,230,118;diffuse,color("0,0,0,0.5");xy,DiffBGPosX(),SCREEN_CENTER_Y+141;visible,GAMESTATE:IsCourseMode() == false);
		OnCommand=cmd(draworder,1;cropright,1;sleep,0.264;sleep,0.6;linear,0.4;cropright,0);
		OffCommand=cmd(sleep,0.033;accelerate,0.363;x,-237);
	};
};
t[#t+1] = Def.ActorFrame{
	LoadActor("SNDifficultyList.lua");
	LoadActor("bpmmeter.lua");
};

-------------------------------------------------------------------------------------------------------------------
-- Mod Icons
-------------------------------------------------------------------------------------------------------------------
t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
		InitCommand=cmd(player,PLAYER_1;x,ModP1PosX();y,SCREEN_CENTER_Y+201;draworder,1);
		OnCommand=cmd(addx,-400;sleep,0.264;decelerate,0.52;addx,400);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
	LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
		InitCommand=cmd(player,PLAYER_2;x,ModP2PosX();y,SCREEN_CENTER_Y+201;draworder,1);
		OnCommand=cmd(addx,-400;sleep,0.264;decelerate,0.52;addx,400);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathG("","_GrooveRadar base (doubleres).png"))..{
		InitCommand=cmd(xy,RadarBasePosX(),SCREEN_CENTER_Y+16);
		OnCommand=cmd(draworder,4;zoomy,0;addx,-400;sleep,0.264;linear,0.2;zoomy,0.3;addx,400;linear,0.2;zoomy,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(diffusealpha,0.75;addx,-400;sleep,0.264;linear,0.2;addx,400);
	OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	create_ddr_groove_radar("P1_radar", RadarPosX(), SCREEN_CENTER_Y+28,
		PLAYER_1, 74, color("1,1,1,0.75"),
		{ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1},
		"accelerate", .25)
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(diffusealpha,0.75;addx,-400;sleep,0.264;linear,0.2;addx,400);
	OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	create_ddr_groove_radar("P2_radar", RadarPosX(), SCREEN_CENTER_Y+28,
		PLAYER_2, 74, color("1,1,1,0.75"),
		{ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2},
		"accelerate", .25)
};
t[#t+1] = Def.ActorFrame{
	LoadActor("radar lights (doubleres)")..{
		InitCommand=cmd(xy,RadarBasePosX(),SCREEN_CENTER_Y+16;diffuseshift;effectcolor1,color("1,1,1,0.75");effectcolor2,color("1,1,1,0.25");effectclock,'beatnooffset');
		OnCommand=cmd(draworder,4;zoomy,0;addx,-400;sleep,0.264;linear,0.2;zoomy,0.3;addx,400;linear,0.2;zoomy,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
};

--new song--
if not GAMESTATE:IsCourseMode() then
	t[#t+1] = StandardDecorationFromFileOptional("NewSong","NewSong") .. {
		InitCommand=cmd(playcommand,"Set");
		BeginCommand=cmd(playcommand,"Set");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
	-- 		local pTargetProfile;
			local sSong;
			-- Start!
			if GAMESTATE:GetCurrentSong() then
				if PROFILEMAN:IsSongNew(GAMESTATE:GetCurrentSong()) then
					self:playcommand("Show");
				else
					self:playcommand("Hide");
				end
			else
				self:playcommand("Hide");
			end
		end;
	};
end;

-- song options text (e.g. 1.5xmusic)
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions")

-- other items (balloons, etc.)
t[#t+1] = StandardDecorationFromFile( "Balloon", "Balloon" );
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","Music_In"))..{
		OnCommand=cmd(play);
	};
};

return t
