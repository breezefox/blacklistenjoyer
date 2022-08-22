SLASH_BLIST1 = "/blist"

local aggroHighlights = setmetatable({}, weaktable)

local function BlacklistEnjoyerHandler(name)
    local names = {}
    for i = 1, MAX_RAID_MEMBERS do
        local name = GetRaidRosterInfo(i);

        if(name ~= nil) then
            -- loop through blacklist and compare
            for i, dada in ipairs(BLACKLISTED_NAMES) do
                if(dada == name) then
                    SendChatMessage("DADA POLICE ALERT: " .. name .. " IS FLAGGED BY THE DADA POLICE - YOUR GAMEPLAY MIGHT BE RUINED" , "RAID", nil, index);
                    SendChatMessage("TEST: " .. i .. " TEST" , "RAID", nil, index);
                end
            end
        end
    end

    for i, item in ipairs(BLACKLISTED_NAMES) do
        print (item)
    end
end

SlashCmdList["BLIST"] = BlacklistEnjoyerHandler





do
    local function getTexture(frame, name)
        while not frame:GetName() do
            frame = frame:GetParent()
        end

        name = name and string.gsub(name, "%$parent", frame:GetName())
        return name and _G[name]
    end

    local function createTexture(frame, name, layer, subLayer)
        return getTexture(frame, name) or frame:CreateTexture(name, layer, nil, subLayer)
    end

    local texCoords = {
        ["Raid-AggroFrame"] = {0.00781250, 0.55468750, 0.00781250, 0.27343750}
    }

    local function setUpFunc(frame)
        if frame:IsForbidden() or aggroHighlights[frame] then
            return
        end
    
        aggroHighlights[frame] = createTexture(frame, "$parentAggroHighlight", "ARTWORK")
        aggroHighlights[frame]:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights")
        aggroHighlights[frame]:SetTexCoord(unpack(texCoords["Raid-AggroFrame"]))
        aggroHighlights[frame]:SetVertexColor(1, 0.1, 0)
        aggroHighlights[frame]:SetAllPoints(frame)
    end

    
    hooksecurefunc("DefaultCompactUnitFrameSetup", setUpFunc)
    hooksecurefunc("DefaultCompactMiniFrameSetup", setUpFunc)
end