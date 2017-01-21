return Def.ActorFrame {
	LoadActor( "1" )..{
		InitCommand=cmd(scaletoclipped,960,720;Center);
	};

	LoadActor( "music" )..{
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	};
}