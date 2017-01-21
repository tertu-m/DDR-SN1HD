local gc = Var("GameCommand");

return Def.ActorFrame {
	LoadFont("_@apex commercial 20px") .. {
		Text=gc:GetText(),
		InitCommand=cmd(uppercase,true;halign,0;zoomy,0.8;skewx,-0.15;zoomx,1.1;strokecolor,color("#000000"));
		GainFocusCommand=function(self) self:finishtweening():diffuse(color("#00FE4E"))
            MESSAGEMAN:Broadcast("TitleSelection", {Choice=gc:GetName()}) end,
		LoseFocusCommand=function(self) self:stopeffect():diffuse(color("#018E2D")) end
	};
	Def.ActorFrame{
		LoadActor("title cursor")..{
			OnCommand=cmd(addx,100;cropright,0.8;sleep,0.2;linear,0.3;cropright,0;faderight,0.2;);
			GainFocusCommand=cmd(finishtweening;cropright,0.8;linear,0.125;addx,-10;sleep,0.12;linear,0.125;cropright,0;diffusealpha,1;addx,10);
			LoseFocusCommand=cmd(finishtweening;linear,0.125;diffusealpha,0);
			OffCommand=cmd(linear,0.3;cropright,1);
		};
	};

};
