local t = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_LEFT+195;y,SCREEN_BOTTOM-80);
	OnCommand=cmd(addx,-390;linear,0.133;addx,390);
	GainFocusCommand=function(s) MESSAGEMAN:Broadcast("PlaySingle") s:visible(true):addx(-11):decelerate(0.1):addx(11) end,
	LoseFocusCommand=cmd(visible,false);
	OffCommand=cmd(linear,0.133;addx,-390);
	-- Information panel
	LoadActor(THEME:GetPathG("","_PlayMode/_infoback.png"))..{
		InitCommand=cmd(zoomx,-1);
	};
	LoadActor(THEME:GetPathG("","_PlayMode/MAX (doubleres).png"))..{
		InitCommand=cmd(halign,0;x,-170;y,40);
	};
	LoadActor(THEME:GetPathG("","_PlayMode/dots.png"))..{
		InitCommand=cmd(x,54;y,42);
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(settext,"ALL MUSIC";skewx,-0.15;halign,0;y,-35;x,-180;zoom,1.75;zoomy,1.25;diffuse,color("#fbfa3e"));
	};
	LoadFont("_russell square 16px")..{
		InitCommand=cmd(skewx,-0.15;halign,0;zoom,0.8;y,-5;x,-180;maxwidth,500;strokecolor,color("#000000"));
		OnCommand=cmd(settext,"Play all songs in this dream-like mode!")
	};
	LoadFont("_russell square 16px")..{
		InitCommand=cmd(skewx,-0.15;halign,0;y,10;x,-180;zoom,0.8;maxwidth,435;strokecolor,color("#000000"));
		OnCommand=cmd(settext,"Beginners can enjoy this mode with advanced players.")
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(halign,0;x,-98;skewx,-0.25;y,44;zoom,1.1;zoomx,2;diffuse,color("#613103"));
		OnCommand=function(self)
		local stages = PREFSMAN:GetPreference("SongsPerPlay")
			self:settext(stages);
		end;
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(halign,0;x,-100;skewx,-0.25;y,42;zoom,1.1;zoomx,2;diffuse,color("#fd8304"));
		OnCommand=function(self)
		local stages = PREFSMAN:GetPreference("SongsPerPlay")
			self:settext(stages);
		end;
	};
};

return t;
