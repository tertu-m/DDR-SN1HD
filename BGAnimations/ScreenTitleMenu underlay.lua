InitUserPrefs();
local t = Def.ActorFrame{
  OnCommand=function(self)
    if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
      Trace("ThemePrefs doesn't exist; creating file")
      ThemePrefs.ForceSave()
    end
    SCREENMAN:SystemMessage("Saving ThemePrefs.")
    ThemePrefs.Save()
  end;
};

return t;
