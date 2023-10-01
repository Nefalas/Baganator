Baganator.Tooltips = {}

function Baganator.Tooltips.AddLines(tooltip, summaries, itemLink)
  if itemLink == nil then
    return
  end

  local key = Baganator.Utilities.GetItemKey(itemLink)

  local tooltipInfo = summaries:GetTooltipInfo(key)

  table.sort(tooltipInfo, function(a, b)
    return a.bags + a.bank + a.mail > b.bags + b.bank + b.mail
  end)

  if #tooltipInfo == 0 then
    return
  end

  local result = "  "
  local bagCount, bankCount, mailCount = 0, 0, 0

  for index, s in ipairs(tooltipInfo) do
    bagCount = bagCount + s.bags
    bankCount = bankCount + s.bank
    mailCount = mailCount + s.mail
  end

  local entries = {}
  if bagCount > 0 then
    table.insert(entries, BAGANATOR_L_BAGS_X:format(bagCount))
  end
  if bankCount > 0 then
    table.insert(entries, BAGANATOR_L_BANKS_X:format(bankCount))
  end
  if mailCount > 0 then
    table.insert(entries, BAGANATOR_L_MAILS_X:format(mailCount))
  end
  tooltip:AddLine(BAGANATOR_L_INVENTORY_TOTALS_COLON .. " " .. WHITE_FONT_COLOR:WrapTextInColorCode(strjoin(", ", unpack(entries))))

  for index = 1, math.min(#tooltipInfo, 4) do
    local s = tooltipInfo[index]
    local entries = {}
    if s.bags > 0 then
      table.insert(entries, BAGANATOR_L_BAGS_X:format(s.bags))
    end
    if s.bank > 0 then
      table.insert(entries, BAGANATOR_L_BANK_X:format(s.bank))
    end
    if s.mail > 0 then
      table.insert(entries, BAGANATOR_L_MAIL_X:format(s.mail))
    end
    tooltip:AddDoubleLine("  " .. s.character, WHITE_FONT_COLOR:WrapTextInColorCode(strjoin(", ", unpack(entries))))
  end
  if #tooltipInfo > 4 then
    tooltip:AddLine("  ...")
  end
end
