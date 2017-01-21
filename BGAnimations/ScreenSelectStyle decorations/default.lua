local t = LoadFallbackB()

t[#t+1] = LoadActor("under bar")..{
	--heh. underbar.
	InitCommand=cmd(xy,SCREEN_RIGHT-150,SCREEN_CENTER_Y+56);
	OnCommand=cmd(addx,379;sleep,0.264;decelerate,0.264;addx,-390;decelerate,0.1;addx,11);
	OffCommand=cmd(decelerate,0.264;addx,379);
};
t[#t+1] = Def.Sprite{
	InitCommand=cmd(x,SCREEN_RIGHT-184;y,SCREEN_CENTER_Y-123);
	OnCommand=function(s) s:addx(379):sleep(0.264):decelerate(0.264):addx(-390):decelerate(0.1):addx(11) end;
	Anim1Command=function(s) s:addx(-11) end,
	Anim2Command=function(s) s:decelerate(0.1):addx(11) end,
	PadsOneMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroll ChoiceSingle/_info")):queuecommand("Anim2") end;
	PadsTwoMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroll ChoiceVersus/_info")):queuecommand("Anim2") end;
	PadsDoubleMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroll ChoiceDouble/_info")):queuecommand("Anim2") end;
	OffCommand=cmd(decelerate,0.264;addx,379);
};

return t
