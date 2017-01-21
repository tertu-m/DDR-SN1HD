local t = LoadFallbackB()

t[#t+1] = LoadActor(THEME:GetPathS("","PlayMode_In"))..{
	OnCommand=cmd(play);
}

--[[t[#t+1] = Def.Sprite{
	InitCommand=cmd(xy,SCREEN_LEFT+240,SCREEN_CENTER_Y-40;rotationz,-25);
	OnCommand=cmd(addx,-640;sleep,0.116;accelerate,0.25;addx,640);
	PlayStarterMessageCommand=function(s) s:Load(THEME:GetPathG("","_PlayMode/Standard")) end,
	PlaySingleMessageCommand=function(s) s:Load(THEME:GetPathG("","_PlayMode/Standard")) end,
	OffCommand=cmd(sleep,0.116;accelerate,0.25;addx,-640);
};]]--
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/confirm"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT+8;y,SCREEN_BOTTOM-40;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/select"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-104;y,SCREEN_BOTTOM-40;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

return t
