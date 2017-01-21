local t = Def.ActorFrame{
  InitCommand=cmd(y,-15);
  LoadActor("confirm")..{
    InitCommand=cmd(x,SCREEN_RIGHT+8;halign,1);
    OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;);
  };
  LoadActor("select")..{
    InitCommand=cmd(x,SCREEN_RIGHT-236;halign,0);
    OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;);
  };
  LoadActor("difficulty")..{
    InitCommand=cmd(x,SCREEN_RIGHT-236;y,20;halign,0);
    OnCommand=cmd(diffuseblink;effectcolor1,0,0,0,0;effectcolor2,1,1,1,1;effectperiod,2;);
  };
  LoadActor("sort")..{
    InitCommand=cmd(x,SCREEN_RIGHT-236;halign,0);
    OnCommand=cmd(diffuseblink;effectcolor1,1,1,1,1;effectcolor2,0,0,0,0;effectperiod,2;);
  };
};

return t;
