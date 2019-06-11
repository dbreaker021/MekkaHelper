--------------------------------------------------------------------------------
-- Mekkatorque Helper
--------------------------------------------------------------------------------

local MekkaHelper = LibStub("AceAddon-3.0"):NewAddon("MekkaHelper", "AceConsole-3.0")

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
local borders = {
    ["Interface\\DialogFrame\\UI-DialogBox-Border"] = "Classic",
    ["Interface\\DialogFrame\\UI-DialogBox-Gold-Border"] = "Classic Gold",
    ["Interface\\Tooltips\\UI-Tooltip-Border"] = "Slick",
    ["Interface\\ACHIEVEMENTFRAME\\UI-Achievement-WoodBorder"] = "Wood",
    ["Interface\\FriendsFrame\\UI-Toast-Border"] = "Hefty",
    [""] = "None",
    ["Interface\\LFGFRAME\\LFGBorder"] = "Graphite"
}

local channel = {
    [1] = "WHISPER",
    [2] = "LOCAL",
    [3] = "RAID",
}

local soundSet = {
    [1] = "音效",
    [2] = "語音",
    [3] = "音效+語音",
}

local backgrounds = {
    ["Interface\\ChatFrame\\ChatFrameBackground"] = "ChatFrameBackground",
    ["Interface\\DialogFrame\\UI-DialogBox-Background"] = "DialogBoxBackground"
}

local array = {"redwrench", "purplechicken", "greenspring", "yellowbolt", "bluegear"}
local arraycolor = {"<1>紅色扳手", "<2>紫色小雞", "<3>綠色彈簧", "<4>黃色螺絲", "<5>藍色齒輪"}
local arraymark = {"{rt7}", "{rt3}", "{rt4}", "{rt1}", "{rt6}"}

local spellData = { 
    [1] = { whisper = '{rt7} {rt7} [1] RED {rt7} {rt7}',    spellID = 286152 },
    [2] = { whisper = '{rt3} {rt3} [2] PURPLE {rt3} {rt3}', spellID = 286192 },
    [3] = { whisper = '{rt4} {rt4} [3] GREEN {rt4} {rt4}',  spellID = 286215 },
    [4] = { whisper = '{rt1} {rt1} [4] YELLOW {rt1} {rt1}', spellID = 286219 },
    [5] = { whisper = '{rt6} {rt6} [5] BLUE {rt6} {rt6}',   spellID = 286226 },
}

local options = {
    name = "MekkaHelper",
    handler = MekkaHelper,
    type = 'group',
    args = {
		-- chat local/privado
		chatshow = { type = 'select', name = 'Channel', desc = '頻道', style = 'dropdown', set = 'SetChat', get = 'GetChat', values = channel, cmdHidden = true, order = 1 },
		chatloc = { type = 'toggle', name = 'Chat Local', desc = '白頻', set = 'SetChatLocal', get = 'IsChatLocal', guiHidden = true },
		chatpriv = { type = 'toggle', name = 'Chat Privado', desc = '私人頻道', set = 'SetChatPrivate', get = 'IsChatLocal', guiHidden = true },
		chatraid = { type = 'toggle', name = 'Chat Raid', desc = '團隊頻道', set = 'SetChatRaid', get = 'IsChatLocal', guiHidden = true },
        -- Locking
        lock_gui = { type = 'toggle', name = 'lock', desc = '鎖定', set = 'ToggleLocked', get = 'IsLocked', cmdHidden = true, order = 2 },
        lock = { type = 'toggle', name = 'Travar', desc = '鎖定UI', set = 'SetLocked', get = 'IsLocked', guiHidden = true },
        l = { type = 'toggle', name = 'Travar', desc = '鎖定UI', set = 'SetLocked', get = 'IsLocked', guiHidden = true },
        unlock = { type = 'toggle', name = 'Destravar', desc = '鎖定UI', set = 'SetUnlocked', get = 'IsLocked', guiHidden = true },
        u = { type = 'toggle', name = 'Destravar', desc = '鎖定UI', set = 'SetUnlocked', get = 'IsLocked', guiHidden = true },

        -- Hide
        hide_gui = { type = 'toggle', name = 'hide', desc = '隱藏/顯示', set = 'ToggleHidden', get = 'IsHidden', cmdHidden = true, order = 3 },
        hide = { type = 'toggle', name = 'Esconder', desc = '隱藏UI', set = 'SetHidden', get = 'IsHidden', guiHidden = true },
        h = { type = 'toggle', name = 'Esconder', desc = '隱藏UI', set = 'SetHidden', get = 'IsHidden', guiHidden = true },

        -- Show
        show = { type = 'toggle', name = 'Mostrar', desc = '顯示UI', set = 'SetShown', get = 'IsShown', guiHidden = true },
        s = { type = 'toggle', name = 'Mostrar', desc = '顯示UI', set = 'SetShown', get = 'IsShown', guiHidden = true },

        -------------------------------------------------------------------------
        -- APPEARANCE
        -------------------------------------------------------------------------
        appearance_header = { type = 'header', name = '外觀', order = 10 },

        -- Border
        border = { type = 'select', name = 'broder', desc = '面板材質', style = 'dropdown', set = 'SetBorder', get = 'GetBorder', values = borders, cmdHidden = true, order = 12 },

        -- Background color
        background_color = { type = 'color', name = 'Color', desc = '背景顏色', get = 'GetBackgroundColor', set = 'SetBackgroundColor', hasAlpha = true, cmdHidden = true, order = 11 },

        -------------------------------------------------------------------------
        -- APPEARANCE
        -------------------------------------------------------------------------
        size_and_orientation_header = { type = 'header', name = '水平垂直與大小', order = 20 },

        -- Flip
        flip = { type = 'toggle', name = 'Alternar', desc = '翻轉UI', set = 'Flip', get = 'GetHorizontal', guiHidden = true },
        f = { type = 'toggle', name = 'Alternar', desc = '翻轉UI', set = 'Flip', get = 'GetHorizontal', guiHidden = true },

        -- Horizontal
        horizontal_gui = { type = 'toggle', name = 'Horizontal', desc = '水平/垂直', set = 'Flip', get = 'GetHorizontal', cmdHidden = true, order = 21 },
        horizontal = { type = 'toggle', name = 'Horizontal', desc = '調整UI為水平顯示', set = 'SetHorizontal', get = 'GetHorizontal', guiHidden = true },
        hor = { type = 'toggle', name = 'Horizontal', desc = '調整UI為水平顯示', set = 'SetHorizontal', get = 'GetHorizontal', guiHidden = true },

        -- Vertical
        vertical = { type = 'toggle', name = 'Vertical', desc = '調整UI為垂直顯示', set = 'SetVertical', get = 'GetVertical', guiHidden = true },
        vert = { type = 'toggle', name = 'Vertical', desc = '調整UI為垂直顯示', set = 'SetVertical', get = 'GetVertical', guiHidden = true },

        -- Toggle
        --toggle = { type = 'toggle', name = 'Mostrar/Esconder', desc = 'Mostra/Esconde o MekkaHelper.', set = 'ToggleHidden', get = 'IsHidden', guiHidden = true },
        --t = { type = 'toggle', name = 'Mostrar/Esconder', desc = 'Mostra/Esconde o MekkaHelper.', set = 'ToggleHidden', get = 'IsHidden', guiHidden = true },

        -- Scale
        scale = { type = 'range', name = 'scale', desc = 'UI大小', set = 'SetScale', get = 'GetScale', min = 0.1, max = 5.0, cmdHidden = true, order = 22 },
		
		
		-------------------------------------------------------------------------
        -- SOUND
        -------------------------------------------------------------------------
		 sound_header = { type = 'header', name = '音效', order = 30 },
		 soundset = { type = 'select', name = 'Sound', desc = '音效', style = 'dropdown', set = 'SetSound', get = 'GetSound', values = soundSet, cmdHidden = true, order = 31 },
    },
}

LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MekkaHelper", "MekkaHelper")
LibStub("AceConfig-3.0"):RegisterOptionsTable("MekkaHelper", options, { "MekkaHelper", "mk" })
local AceGUI = LibStub("AceGUI-3.0")

--------------------------------------------------------------------------------
-- MekkaHelper FRAME CREATION FUNCTION
--------------------------------------------------------------------------------
function MekkaHelper:CreateMekkaHelperFrame()
    local mkFrame = AceGUI:Create("MekkaHelperFrame")
	
	C_ChatInfo.RegisterAddonMessagePrefix("MekkaHelper")

    for i = 1, 5 do
        local targetIcon = AceGUI:Create("Icon")
        targetIcon:SetImage("INTERFACE/ICONS/spell_mekkatorque_bot_" .. array[i])
        targetIcon:SetWidth(36)
        targetIcon:SetHeight(36)
        targetIcon:SetImageSize(36, 36)
		targetIcon:SetCallback("OnClick", function(self, button)
			
			local name = GetUnitName("target" , true)
			if name ~= nil then
				SendChatMessage("## " .. arraymark[i] .. arraymark[i] .. " " .. name .. " = " .. arraycolor[i] .. " " .. arraymark[i] .. arraymark[i] .. " ##", MekkaHelper:ChatCheck(), nil, name)
				C_ChatInfo.SendAddonMessage("MekkaHelper", i, 'WHISPER', name);
			end
        end)
        mkFrame:AddChild(targetIcon)
    end
		
	mkFrame.icon = {}
	mkFrame.icon = AceGUI:Create("Icon")
	mkFrame.icon:SetImage("INTERFACE/ICONS/Inv_misc_questionmark")
	mkFrame.icon:SetLabel("?")
	mkFrame.icon:SetWidth(36)
	mkFrame.icon:SetHeight(36)
	mkFrame.icon:SetImageSize(36, 36)
	mkFrame:AddChild(mkFrame.icon)
	
    return mkFrame
end

local MK_FRAME = MekkaHelper:CreateMekkaHelperFrame()
local DEBUG = false

--------------------------------------------------------------------------------
-- Layout
--------------------------------------------------------------------------------
function MekkaHelper:SetHorizontalLayout()
    MK_FRAME:SetWidth(250)
    MK_FRAME:SetHeight(80)
    MK_FRAME:SetLayout("Flow")
    self.db.char.horizontal = true
    if DEBUG then MekkaHelper:Print("Horizontal Layout") end
    return self.db.char.horizontal
end

function MekkaHelper:SetVerticalLayout()
    MK_FRAME:SetWidth(60)
    MK_FRAME:SetHeight(300)
    MK_FRAME:SetLayout("List")
    MekkaHelper.db.char.horizontal = false
    if DEBUG then MekkaHelper:Print("Vertical Layout") end
    return self.db.char.horizontal
end

function MekkaHelper:GetHorizontal(info)
    return self.db.char.horizontal
end

function MekkaHelper:SetHorizontal(info, input)
    return MekkaHelper:SetHorizontalLayout()
end

function MekkaHelper:GetVertical(info)
    return not self.db.char.horizontal
end

function MekkaHelper:SetVertical(info, input)
    return MekkaHelper:SetVerticalLayout()
end

function MekkaHelper:Flip(info, input)
    if self.db.char.horizontal then
        MekkaHelper:SetVerticalLayout()
    else
        MekkaHelper:SetHorizontalLayout()
    end
end

--------------------------------------------------------------------------------
-- Chat
--------------------------------------------------------------------------------

function MekkaHelper:ChatLocal()
    -- MK_FRAME:ChatLocal()
    self.db.char.mkchat = 1
    if DEBUG then MekkaHelper:Print("Chat Local") end
end

function MekkaHelper:ChatPrivate()
    -- MK_FRAME:ChatPrivate()
    self.db.char.mkchat = 2
    if DEBUG then MekkaHelper:Print("Chat Privado") end
end

function MekkaHelper:ChatRaid()
    -- MK_FRAME:ChatPrivate()
    self.db.char.mkchat = 3
    if DEBUG then MekkaHelper:Print("Chat Raid") end
end

function MekkaHelper:IsChatLocal(info)
    return self.db.char.mkchat
end

function MekkaHelper:ChatCheck()
	local ChatIsTrue = {"WHISPER","SAY","RAID"}
	return ChatIsTrue[self.db.char.mkchat]
end

function MekkaHelper:SetChat(info, input)
    MekkaHelper:Chat(input)
end

function MekkaHelper:GetChat(info, input)
    return self.db.char.mkchat
end

function MekkaHelper:Chat(num)
    self.db.char.mkchat = num
end

function MekkaHelper:SetChatLocal(info, input)
    MekkaHelper:ChatLocal()
end

function MekkaHelper:SetChatPrivate(info, input)
    MekkaHelper:ChatPrivate()
end

function MekkaHelper:SetChatRaid(info, input)
    MekkaHelper:ChatRaid()
end

function MekkaHelper:SetSound(info, input)
    self.db.char.mksound = input
end

function MekkaHelper:GetSound(info, input)
    return self.db.char.mksound
end

--------------------------------------------------------------------------------
-- Locking
--------------------------------------------------------------------------------
function MekkaHelper:Lock()
    MK_FRAME:Lock()
    self.db.char.locked = true
    if DEBUG then MekkaHelper:Print("Locked") end
end

function MekkaHelper:Unlock()
    MK_FRAME:Unlock()
    self.db.char.locked = false
    if DEBUG then MekkaHelper:Print("Unlocked") end
end

function MekkaHelper:IsLocked(info)
    return self.db.char.locked
end

function MekkaHelper:ToggleLocked(info, input)
    if self.db.char.locked then
        MekkaHelper:Unlock()
    else
        MekkaHelper:Lock()
    end
end

function MekkaHelper:SetLocked(info, input)
    MekkaHelper:Lock()
end

function MekkaHelper:SetUnlocked(info, input)
    MekkaHelper:Unlock()
end

--------------------------------------------------------------------------------
-- Positioning
--------------------------------------------------------------------------------
function MekkaHelper:SetPosition(point, relativePoint, x, y)
    MK_FRAME:ClearAllPoints()
    MK_FRAME:SetPoint(point, UIParent, relativePoint, x, y)
    if DEBUG then
        MekkaHelper:Print("Positioning at " .. x .. ", " .. y .. " relative to " .. relativePoint)
    end
end

--------------------------------------------------------------------------------
-- Scaling
--------------------------------------------------------------------------------
function MekkaHelper:Scale(scale)
    MK_FRAME.frame:SetScale(scale)
    self.db.char.scale = scale
    if DEBUG then MekkaHelper:Print("Scale set to " .. scale * 100 .. "%") end
end

function MekkaHelper:GetScale(info)
    return self.db.char.scale
end

function MekkaHelper:SetScale(info, scale)
    MekkaHelper:Scale(scale)
end

--------------------------------------------------------------------------------
-- Displaying
--------------------------------------------------------------------------------
function MekkaHelper:Toggle()
    if self.db.char.hidden then
        return MekkaHelper:Show()
    else
        return MekkaHelper:Hide()
    end
end

function MekkaHelper:Show()
    MK_FRAME:Show()
    self.db.char.hidden = false
    if DEBUG then MekkaHelper:Print("Shown") end
end

function MekkaHelper:Hide()
    MK_FRAME:Hide()
    self.db.char.hidden = true
    if DEBUG then MekkaHelper:Print("Hidden") end
end

function MekkaHelper:IsShown(info)
    return not self.db.char.hidden
end

function MekkaHelper:IsHidden(info)
    return self.db.char.hidden
end

function MekkaHelper:SetShown(info, input)
    MekkaHelper:Show()
end

function MekkaHelper:SetHidden(info, input)
    MekkaHelper:Hide()
end

function MekkaHelper:ToggleHidden(info, input)
    if self.db.char.hidden then
        MekkaHelper:Show()
    else
        MekkaHelper:Hide()
    end
end

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------
function MekkaHelper:Border(edge_file)
    self.db.char.edge_file = edge_file
    MK_FRAME:SetBackdrop(self.db.char.edge_file, self.db.char.bg_color_r, self.db.char.bg_color_g, self.db.char.bg_color_b, self.db.char.bg_color_a)
    if DEBUG then MekkaHelper:Print("Border changed") end
end

function MekkaHelper:GetBorder(info, input)
    return self.db.char.edge_file
end

function MekkaHelper:SetBorder(info, input)
    MekkaHelper:Border(input)
end

function MekkaHelper:BackgroundColor(r, g, b, a)
    self.db.char.bg_color_r = r
    self.db.char.bg_color_g = g
    self.db.char.bg_color_b = b
    self.db.char.bg_color_a = a
    MK_FRAME:SetBackdrop(self.db.char.edge_file, self.db.char.bg_color_r, self.db.char.bg_color_g, self.db.char.bg_color_b, self.db.char.bg_color_a)
    if DEBUG then MekkaHelper:Print("Color changed") end
end

function MekkaHelper:GetBackgroundColor(info, r, g, b, a)
    return self.db.char.bg_color_r, self.db.char.bg_color_g, self.db.char.bg_color_b, self.db.char.bg_color_a
end

function MekkaHelper:SetBackgroundColor(info, r, g, b, a)
    MekkaHelper:BackgroundColor(r, g, b, a)
end

-- DEPRECATED: Only here for those using the 2.0 API, use MekkaHelper:Toggle() instead.
function MekkaHelper_ToggleForm()
    MekkaHelper:Toggle()
end

--------------------------------------------------------------------------------
-- Load Settings
--------------------------------------------------------------------------------
function MekkaHelper:LoadSettings()
    -- Set Position
    if self.db.char.point ~= nil then
        MekkaHelper:SetPosition(self.db.char.point, self.db.char.relativePoint, self.db.char.xOfs, self.db.char.yOfs)
    end

    -- Set Orientation
    if self.db.char.horizontal then
        MekkaHelper:SetHorizontalLayout()
    else
        MekkaHelper:SetVerticalLayout()
    end

    -- Set Locked Status
    if self.db.char.locked then
        MekkaHelper:Lock()
    else
        MekkaHelper:Unlock()
	end
	
	if self.db.char.mkchat == 1 then
        MekkaHelper:ChatPrivate()
    elseif self.db.char.mkchat == 2 then
        MekkaHelper:ChatLocal()
	else
		MekkaHelper:ChatRaid()
    end

    -- Set Hidden Status
    if self.db.char.hidden then
        MekkaHelper:Hide()
    else
        MekkaHelper:Show()
    end

    -- Set Scale
    if self.db.char.scale then
        MekkaHelper:Scale(self.db.char.scale)
    else
        MekkaHelper:Scale(1.0)
    end

    -- Set Border
    if self.db.char.edge_file then
        MekkaHelper:Border(self.db.char.edge_file)
    else
        MekkaHelper:Border("Interface\\DialogFrame\\UI-DialogBox-Gold-Border")
    end

    if self.db.char.bg_color_r and self.db.char.bg_color_g and self.db.char.bg_color_b and self.db.char.bg_color_a then
        MekkaHelper:BackgroundColor(self.db.char.bg_color_r, self.db.char.bg_color_g, self.db.char.bg_color_b, self.db.char.bg_color_a)
    else
        MekkaHelper:BackgroundColor(0, 0, 0, 0.3)
    end
	
	--Set sound
	if not self.db.char.mksound then
		self.db.char.mksound = 1
	end
		
end

--------------------------------------------------------------------------------
-- INITIALIZATION FUNCTION
--------------------------------------------------------------------------------
function MekkaHelper:OnInitialize()
    if DEBUG then MekkaHelper:Print("Initializing settings") end

    self.db = LibStub("AceDB-3.0"):New("MekkaHelperDB")
	
    -- XXX: This might have performance problems but it is safe in terms of data consistency.
    MK_FRAME.frame:SetScript("OnLeave", function()
        point, relativeTo, relativePoint, xOfs, yOfs = MK_FRAME.frame:GetPoint()
        if relativeTo == nil then
            self.db.char.point = point
            self.db.char.relativePoint = relativePoint
            self.db.char.xOfs = xOfs
            self.db.char.yOfs = yOfs
            if DEBUG then
                MekkaHelper:Print("Positioning at " .. point .. " at " .. xOfs .. ", " .. yOfs .. " relative to " .. relativePoint)
            end
        end
    end)

    MekkaHelper:LoadSettings()
end

function MekkaHelper:OnEnable()
    if DEBUG then MekkaHelper:Print("Enabled") end
end

function MekkaHelper:OnDisable()
    if DEBUG then MekkaHelper:Print("Disabled") end
end

local events = CreateFrame('Frame');
events:RegisterEvent('CHAT_MSG_ADDON');
events:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
events:RegisterEvent('UNIT_ENTERED_VEHICLE');
events:SetScript('OnEvent', function(self, event, ...) return self[event](self, event, ...); end);

function events:CHAT_MSG_ADDON(_, event, i)
	if event == "MekkaHelper" then
		if MekkaHelper:GetSound() == 1 then
			PlaySoundFile("Sound\\Spells\\LevelUp.ogg")
		elseif MekkaHelper:GetSound() == 2 then
			PlaySoundFile("Interface\\Addons\\MekkaHelper\\sounds\\" .. i .. ".mp3")
		else
			PlaySoundFile("Sound\\Spells\\LevelUp.ogg")
			PlaySoundFile("Interface\\Addons\\MekkaHelper\\sounds\\" .. i .. ".mp3")
		end
		MK_FRAME.icon:SetImage("INTERFACE/ICONS/spell_mekkatorque_bot_" .. array[tonumber(i)])
		MK_FRAME.icon:SetLabel(i)
	end
end

function events:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellID)
    local spellID = tonumber(spellID);
    if unit == 'player' or unit == 'pet' then
        for i = 1, 5 do
            if spellID == spellData[i].spellID then
                MK_FRAME.icon:SetImage("INTERFACE/ICONS/Inv_misc_questionmark")
				MK_FRAME.icon:SetLabel("?")
                break;
            end
        end
    end
end

function events:UNIT_ENTERED_VEHICLE(_, unit, ...)
    if unit == 'player' then
		MK_FRAME.icon:SetImage("INTERFACE/ICONS/Inv_misc_questionmark")
		MK_FRAME.icon:SetLabel("?")
	end
end


