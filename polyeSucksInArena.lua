local function displayWarning(playerName, playerClass)
    local warningFrame = CreateFrame("Frame", nil, UIParent)
    warningFrame:SetSize(400, 100)
    warningFrame:SetPoint("CENTER", UIParent, "CENTER")

    local warningText = warningFrame:CreateFontString(nil, "ARTWORK", "GameFont_Gigantic")
    warningText:SetPoint("CENTER")
    warningText:SetText("MASS DISPELL on " .. playerName .. " (" .. playerClass .. ")")
    warningText:SetTextColor(1, 0, 0)

    warningFrame:Show()

    PlaySoundFile("Interface\\AddOns\\polyesucksinarena\\sound\\massdispel.mp3", "Master")

    C_Timer.After(3, function() warningFrame:Hide() end)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(_, _, unit)
    for i = 1, 3 do
        local arenaUnit = "arena" .. i
        if unit == arenaUnit then
            for j = 1, 40 do
                local _, _, _, _, _, _, _, _, _, spellId = UnitBuff(arenaUnit, j)
                if spellId == 642 then 
                    local playerName = UnitName(arenaUnit)
                    local playerClass, _ = UnitClass(arenaUnit)
                    displayWarning(playerName, playerClass)
                    return
                end
            end
        end
    end
end)