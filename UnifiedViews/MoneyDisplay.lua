function Baganator.ShowGoldSummaryRealm(anchor, point)
  GameTooltip:SetOwner(anchor, point)

  local connectedRealms = Syndicator.Utilities.GetConnectedRealms()
  local realmsToInclude = {}
  for _, r in ipairs(connectedRealms) do
    realmsToInclude[r] = true
  end

  local lines = {}
  local total = 0
  for _, characterInfo in ipairs(Baganator.Utilities.GetAllCharacters()) do
    if realmsToInclude[characterInfo.realmNormalized] and not SYNDICATOR_DATA.Characters[characterInfo.fullName].details.hidden then
      local money = SYNDICATOR_DATA.Characters[characterInfo.fullName].money
      local characterName = characterInfo.name
      if #connectedRealms > 1 then
        characterName = characterInfo.fullName
      end
      if characterInfo.className then
        characterName = "|c" .. (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[characterInfo.className].colorStr .. characterName .. "|r"
      end
      if Baganator.Config.Get(Baganator.Config.Options.SHOW_CHARACTER_RACE_ICONS) and characterInfo.race then
        characterName = Syndicator.Utilities.GetCharacterIcon(characterInfo.race, characterInfo.sex) .. " " .. characterName
      end
      table.insert(lines, {left = characterName, right = Baganator.Utilities.GetMoneyString(money, true)})
      total = total + money
    end
  end

  GameTooltip:AddDoubleLine(BAGANATOR_L_REALM_WIDE_GOLD_X:format(""), WHITE_FONT_COLOR:WrapTextInColorCode(Baganator.Utilities.GetMoneyString(total, true)))
  GameTooltip:AddLine(" ")
  for _, line in ipairs(lines) do
    GameTooltip:AddDoubleLine(line.left, line.right, nil, nil, nil, 1, 1, 1)
  end
  GameTooltip_AddBlankLineToTooltip(GameTooltip)
  GameTooltip:AddLine(BAGANATOR_L_HOLD_SHIFT_TO_SHOW_ACCOUNT_TOTAL, 0, 1, 0)
  GameTooltip:Show()
end

function Baganator.ShowGoldSummaryAccount(anchor, point)
  GameTooltip:SetOwner(anchor, point)

  local lines = {}
  local function AddRealm(realmName, realmCount, realmTotal)
    table.insert(lines, {left = BAGANATOR_L_REALM_X_X_X:format(realmName, realmCount), right = Baganator.Utilities.GetMoneyString(realmTotal, true)})
  end
  local total = 0
  local realmTotal = 0
  local realmCount = 0
  local currentRealm
  for _, characterInfo in ipairs(Baganator.Utilities.GetAllCharacters()) do
    if not SYNDICATOR_DATA.Characters[characterInfo.fullName].details.hidden then
      if currentRealm ~= nil and currentRealm ~= characterInfo.realm then
        AddRealm(currentRealm, realmCount, realmTotal)
        realmTotal = 0
        realmCount = 0
      end
      currentRealm = characterInfo.realm
      realmCount = realmCount + 1

      local money = SYNDICATOR_DATA.Characters[characterInfo.fullName].money

      total = total + money
      realmTotal = realmTotal + money
    end
  end
  AddRealm(currentRealm, realmCount, realmTotal)

  GameTooltip:AddDoubleLine(BAGANATOR_L_ACCOUNT_GOLD_X:format(""), WHITE_FONT_COLOR:WrapTextInColorCode(Baganator.Utilities.GetMoneyString(total, true)))
  GameTooltip:AddLine(" ")
  for _, line in ipairs(lines) do
    GameTooltip:AddDoubleLine(line.left, line.right, nil, nil, nil, 1, 1, 1)
  end
  GameTooltip:Show()
end
