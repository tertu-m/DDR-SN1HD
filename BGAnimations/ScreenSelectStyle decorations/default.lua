local t = LoadFallbackB()

t[#t+1] = LoadActor("under bar")..{
	--heh. underbar.
	InitCommand=cmd(xy,SCREEN_RIGHT-150,SCREEN_CENTER_Y+56);
	OnCommand=cmd(addx,379;sleep,0.264;decelerate,0.264;addx,-390;decelerate,0.1;addx,11);
	OffCommand=cmd(decelerate,0.264;addx,379);
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_RIGHT-184;y,SCREEN_CENTER_Y-123);
	OnCommand=function(s) s:addx(379):sleep(0.264):decelerate(0.264):addx(-390):decelerate(0.1):addx(11) end;
	Anim1Command=function(s) s:addx(-11) end,
	Anim2Command=function(s) s:decelerate(0.1):addx(11) end,
	PadsOneMessageCommand=function(s)
		s:queuecommand("Anim1"):queuecommand("Anim2") end;
	PadsTwoMessageCommand=function(s)
		s:queuecommand("Anim1"):queuecommand("Anim2") end;
	PadsDoubleMessageCommand=function(s)
		s:queuecommand("Anim1"):queuecommand("Anim2") end;
	OffCommand=cmd(decelerate,0.264;addx,379);
	-- Information panel
	LoadActor(THEME:GetPathG("","_PlayMode/_infoback"));
	LoadActor(THEME:GetPathG("","_PlayMode/MAX (doubleres).png"))..{
		InitCommand=cmd(halign,0;x,-112;y,44);
	};
	LoadActor(THEME:GetPathG("","_PlayMode/dots"))..{
		InitCommand=cmd(x,114;y,43);
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(skewx,-0.15;halign,0;y,-35;x,-180;zoom,1.75;zoomy,1.25;diffuse,color("#fbfa3e"));
		PadsOneMessageCommand=function(s)
			s:settext("SINGLE") end,
		PadsTwoMessageCommand=function(s)
			s:settext("VERSUS") end,
		PadsDoubleMessageCommand=function(s)
			s:settext("DOUBLE") end,
	};
	LoadFont("_russell square 16px")..{
		InitCommand=cmd(skewx,-0.15;halign,0;zoom,0.8;y,-5;x,-180;maxwidth,600;strokecolor,color("#000000"));
		PadsOneMessageCommand=function(s)
			s:settext("One player game using the standard") end,
		PadsTwoMessageCommand=function(s)
			s:settext("Two players compete with each other") end,
		PadsDoubleMessageCommand=function(s)
			s:settext("One player game using") end,
	};
	LoadFont("_russell square 16px")..{
		InitCommand=cmd(skewx,-0.15;halign,0;y,10;x,-180;zoom,0.8;maxwidth,435;strokecolor,color("#000000"));
		PadsOneMessageCommand=function(s)
			s:settext("four-arrow Dance Mat.") end,
		PadsTwoMessageCommand=function(s)
			s:settext("using the standard four-arrow Dance Mats.") end,
		PadsDoubleMessageCommand=function(s)
			s:settext("two Dance Mats;For Expert dancers!") end,
		};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(halign,0;x,-36;skewx,-0.25;y,44;zoom,1.5;zoomx,2.5;diffuse,color("#613103"));
		OnCommand=function(self)
		local stages = PREFSMAN:GetPreference("SongsPerPlay")
			self:settext(stages);
		end;
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(halign,0;x,-38;skewx,-0.25;y,42;zoom,1.5;zoomx,2.5;diffuse,color("#fd8304"));
		OnCommand=function(self)
		local stages = PREFSMAN:GetPreference("SongsPerPlay")
			self:settext(stages);
		end;
	};
};

return t
