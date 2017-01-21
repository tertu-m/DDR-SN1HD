local t = Def.ActorFrame{
	LoadActor("caution")..{
		OnCommand=cmd(Center);
	};
};
return t;
