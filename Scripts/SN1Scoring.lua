--This is an implementation of DDR SuperNOVA scoring as described
--by Aaron Chmielowiec at http://aaronin.jp/ddrssystem.html#ss8

--To use it, you can call PrepareScoringInfo at the start of each stage or course.

--Shared functions/data

SN1Scoring = {}
--ScoringInfo is used and maintained solely by PrepareScoringInfo.
ScoringInfo = {
    seed = nil
}

--The multiplier tables have to be filled in completely.
local normalScoringMults = 
{
    TapNoteScore_W1 = 1,
    TapNoteScore_W2 = 1,
    TapNoteScore_W3 = 0.5,
    TapNoteScore_W4 = 0,
    TapNoteScore_W5 = 0,
    TapNoteScore_Miss = 0
}

local courseScoringMults =
{
	TapNoteScore_W1 = 1,
	TapNoteScore_W2 = 2/3,
	TapNoteScore_W3 = 1/3,
	TapNoteScore_W4 = 0,
	TapNoteScore_W5 = 0,
	TapNoteScore_Miss = 0
}

local maxQuasiMultipliers = 
{
    TapNoteScore_W1 = 1,
    TapNoteScore_W2 = 1,
    TapNoteScore_W3 = 1,
    TapNoteScore_W4 = 1,
    TapNoteScore_W5 = 1,
    TapNoteScore_Miss = 1
}

local maxScore = 10000000

local function MakeScoringFunctions(object, pn, course)
    local radar = object:GetRadarValues(pn)
    local objectCount = radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls')
    local package = {}

    local function ComputeScore(pss, max)
        local maxFraction = 0
        local tnsMultipliers, hnsMultipliers
    
        if max then
            tnsMultipliers = maxQuasiMultipliers
            hnsMultipliers = {HoldNoteScore_Held = 1, HoldNoteScore_LetGo = 1}
        else
            tnsMultipliers = course and courseScoringMults or normalScoringMults
            hnsMultipliers = {HoldNoteScore_Held = 1}
        end
        local scoreCount
        for tns, multiplier in pairs(tnsMultipliers) do
            scoreCount = pss:GetTapNoteScores(tns)
            maxFraction = maxFraction + (scoreCount * multiplier)
        end
        for hns, multiplier in pairs(hnsMultipliers) do
            scoreCount = pss:GetHoldNoteScores(hns)
            maxFraction = maxFraction + (scoreCount * multiplier)
        end
        return (maxFraction/objectCount) * maxScore
    end 

    package.AddTapScore = function() end
    package.AddHoldScore = function() end

    package.GetCurrentScore = function(pss, stage, exact)
        if exact then
            return ComputeScore(pss, false)
        end
        return math.floor(ComputeScore(pss, false))
    end

    package.GetCurrentMaxScore = function(pss, stage)
        return ComputeScore(pss, true)
    end

    return package
end

function SN1Scoring.PrepareScoringInfo()
    if GAMESTATE then
        local stageSeed = GAMESTATE:GetStageSeed()
        --if the seed hasn't changed, we're in the same game so we don't want
        --to re-initialize
        if stageSeed == ScoringInfo.seed then return end
        ScoringInfo.seed = stageSeed
        local inCourse = GAMESTATE:IsCourseMode()
        local dataFetcher = inCourse and GameState.GetCurrentTrail or GameState.GetCurrentSteps
        for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
            local data = dataFetcher(GAMESTATE,pn)
            if data then
                ScoringInfo[pn] = MakeScoringFunctions(data,pn,inCourse)
            end
        end
    end
end

SN1Scoring.MakeNormalScoringFunctions = function(data,pn) return MakeScoringFunctions(data, pn, false) end
SN1Scoring.MakeCourseScoringFunctions = function(data,pn) return MakeScoringFunctions(data, pn, true) end

-- (c) 2015-2017 John Walstrom, "Inorizushi"
-- All rights reserved.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, and/or sell copies of the Software, and to permit persons to
-- whom the Software is furnished to do so, provided that the above
-- copyright notice(s) and this permission notice appear in all copies of
-- the Software and that both the above copyright notice(s) and this
-- permission notice appear in supporting documentation.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
-- THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS
-- INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT
-- OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
-- OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
-- PERFORMANCE OF THIS SOFTWARE.
