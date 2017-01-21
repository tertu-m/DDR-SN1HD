local t = Def.ActorFrame{
  InitCommand=cmd(y,-15);
  LoadActor("confirm")..{
    InitCommand=cmd(x,SCREEN_RIGHT+8;halign,1);
  };
  LoadActor("select")..{
    InitCommand=cmd(x,SCREEN_RIGHT-104;halign,1);
  };
};

return t;
