local counter = 0;
local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	Def.ActorFrame{
	InitCommand=cmd(Center);
		LoadActor("ddrsn_logobg.png");
		LoadActor("brillo_bg1")..{
			InitCommand=cmd(blend,Blend.Add;;glow,color("#EEAD7C");diffusealpha,0.05);
		};
		LoadActor("brillo_bg2")..{
			InitCommand=cmd(blend,Blend.Add;;glow,color("#EEAD7C");diffusealpha,0.05;spin;effectmagnitude,0,0,80);
		};
		LoadActor("brillo_bg3")..{
			InitCommand=cmd(blend,Blend.Add;;glow,color("#EEAD7C");diffusealpha,0.05;spin;effectmagnitude,0,0,80);
		};
		LoadActor("brillo_bg4")..{
			InitCommand=cmd(blend,Blend.Add;;glow,color("#EEAD7C");diffusealpha,0.05;spin;effectmagnitude,0,0,-80);
		};
		LoadActor("brillo_bg5")..{
			InitCommand=cmd(blend,Blend.Add;;glow,color("#EEAD7C");diffusealpha,0.05;spin;effectmagnitude,0,0,-80);
		};
	};
	Def.ActorFrame{
		LoadActor("ddrsn_logo.png")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-14);
		};
		LoadActor("ddrsn_konami")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40);
		};
	};
};

return t;
