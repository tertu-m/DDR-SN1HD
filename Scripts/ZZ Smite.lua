--A little experiment

--Shared functions/data

SN1Scoring = {}
--ScoringInfo is used and maintained solely by PrepareScoringInfo.
ScoringInfo = {
    seed = nil
}

local function NormalFormuler(delta)
    delta = math.abs(delta)
    if delta <= 0.01 then return 1
    elseif delta >= 0.16 then return 0
    else return clamp(25.005*delta^2-12.49*delta+1.2893, 0, 1)
    end
end

local function CourseFormuler(delta)
    delta = math.abs(delta)
    if delta <= 0.01 then return 1
    elseif delta >= 0.16 then return 0
    else return clamp(-0.459*math.log(delta)-0.8801, 0, 1)
    end
end

local ignoredJudges = {
    TapNoteScore_CheckpointHit = true,
    TapNoteScore_CheckpointMiss = true,
    TapNoteScore_HitMine = true,
    TapNoteScore_AvoidMine = true,
    TapNoteScore_None = true
}

local maxScore = 10000000

local function MakeScoringFunctions(object, pn, course)
    SCREENMAN:SystemMessage("Smite enabled.")
    local radar = object:GetRadarValues(pn)
    local objectCount = radar:GetValue('RadarCategory_TapsAndHolds')+(radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'))/2
    local package = {}
    local formuler = course and NormalFormuler or CourseFormuler
    local curFraction = 0
    local curMaxFraction = 0

    local function ComputeScore(_, max)
        return ((max and curMaxFraction or curFraction)/objectCount) * maxScore
    end 

    package.AddTapScore = function(params) 
        if not ignoredJudges[params.TapNoteScore] then
            curFraction = curFraction + formuler(params.TapNoteOffset)
            curMaxFraction = curMaxFraction + 1
        end
    end
    package.AddHoldScore = function(params) 
        if params.HoldNoteScore == 'HoldNoteScore_Held' then
            curFraction = curFraction + 0.5
        end
        curMaxFraction = curMaxFraction + 0.5
    end

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
                ScoringInfo[pn] = MakeScoringFunctions(data, pn, inCourse)
            end
        end
    end
end

SN1Scoring.MakeNormalScoringFunctions = function(object, pn) return MakeScoringFunctions(object, pn, false) end
SN1Scoring.MakeCourseScoringFunctions = function(object, pn) return MakeScoringFunctions(object, pn, true) end

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
