local screenName = Var "LoadingScreen"

local t = Def.ActorFrame{
	LoadActor("top(doubleres).png")..{
		InitCommand=cmd(x,SCREEN_LEFT-2;halign,0);
	};
};

return t;
