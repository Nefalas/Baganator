BaganatorCategoryViewsCategoryButtonMixin = {}

function BaganatorCategoryViewsCategoryButtonMixin:OnLoad()
  self:GetFontString():SetJustifyH("LEFT")
  self:GetFontString():SetWordWrap(false)
  self:GetFontString():SetPoint("LEFT")
  self:GetFontString():SetPoint("RIGHT")
  self:RegisterForClicks("AnyUp")
end

function BaganatorCategoryViewsCategoryButtonMixin:Resize()
  self:SetSize(self:GetFontString():GetUnboundedStringWidth(), self:GetFontString():GetHeight())
end

function BaganatorCategoryViewsCategoryButtonMixin:OnClick(button)
  if button == "RightButton" and self.categorySearch then
    self:GetParent():TransferCategory(self.categorySearch)
  end
end

function BaganatorCategoryViewsCategoryButtonMixin:OnEnter()
end

function BaganatorCategoryViewsCategoryButtonMixin:OnLeave()
end

function Baganator.CategoryViews.GetSectionButtonPool(parent)
  return CreateFramePool("Button", parent, nil, nil, false, function(button)
    if button.arrow then
      return
    end
    button:SetNormalFontObject("GameFontNormalMed2")
    button:SetText(" ")
    button:GetFontString():SetPoint("LEFT", 20, 0)
    button:GetFontString():SetPoint("RIGHT")
    button:GetFontString():SetJustifyH("LEFT")
    button:SetHeight(20)
    button.arrow = button:CreateTexture(nil, "ARTWORK")
    button.arrow:SetSize(14, 14)
    button.arrow:SetAtlas("bag-arrow")
    button.arrow:SetPoint("LEFT")
    function button:SetExpanded()
      button.arrow:SetRotation(math.pi/2)
    end
    function button:SetCollapsed()
      button.arrow:SetRotation(-math.pi)
    end
    Baganator.Skins.AddFrame("CategorySectionHeader", button)
    return button
  end)
end
