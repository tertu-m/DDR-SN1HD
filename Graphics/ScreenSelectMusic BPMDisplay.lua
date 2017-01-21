return Def.BPMDisplay{
	Name="BPMDisplay";
	File=THEME:GetPathF("BPMDisplay", "bpm");
	CurrentSongChangedMessageCommand=function(self)
		self:SetFromGameState()
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			(THEME:GetMetric("BPMDisplay","SetExtraCommand"))(self)
		end
	end;
};
