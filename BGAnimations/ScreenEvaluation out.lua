local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
  LoadActor("_evalOut")..{
    OnCommand=cmd(sleep,1);
    OffCommand=cmd(play);
  };
};
return t;
