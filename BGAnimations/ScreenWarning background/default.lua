local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
	};
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center);
	LoadActor("00095");
};

return t;
