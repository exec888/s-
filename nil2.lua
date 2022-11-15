local UILibrary = {}


local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Player788/luau1/main/lib.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local screenGui = lib.Create("ScreenGui", game.CoreGui, {
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
})
if syn then
	syn.protect_gui(screenGui)
	screenGui.Parent = game.CoreGui
elseif gethui then
	screenGui.Parent = gethui()
elseif not game:GetService("RunService"):IsStudio() then
	screenGui.Parent = game.CoreGui
end
local instanceLog = {}
local textlog = {}
local config = {Save = false, ConfigFolder = nil}
local Keys = {}

function Sync(meta, code)
	if typeof(isfolder) ~= "function" then return end
	if not isfolder(config.ConfigFolder) then makefolder(config.ConfigFolder) end
	if not isfile(meta[1]) then writefile(config.ConfigFolder.."/"..meta[1]..".txt", meta[2]) end
	if code == 1 then
		writefile(config.ConfigFolder.."/"..meta[1]..".txt", meta[2])
	elseif code == 0 then
		return readfile(meta[1])
	end
end

function UILibrary:Window(Table)
	local cache = {
		HubName = Table.Name or game.Name, 
		ScriptName = Table.ScriptName or '<font color="rgb(255, 255, 127)">UNLISTED</font>', 
		Creator = Table.Creator or '<font color="rgb(255, 255, 127)">UNLISTED</font>',
		Hotkey = "Comma"
	}

	local mainkey
	if Table.Hotkey then
		mainkey = Enum.KeyCode[Table.Hotkey[1]]
		cache.Hotkey = Table.Hotkey[1]
	else
		mainkey = Enum.KeyCode["Comma"]
		cache.Hotkey = "Comma"
	end
	if Table.SaveConfig then
		config.Save = Table.SaveConfig[2]
		config.ConfigFolder = Table.SaveConfig[1]
	else
		config.Save = false
	end

	Sys('<font color="rgb(85, 170, 127)">Loading..</font>', "["..cache.HubName.."] "  .. cache.ScriptName .. " by " .. cache.Creator, 60)
	function UILibrary:Destroy()
		screenGui:Destroy()
		if Table.OnClose then
			return Table.OnClose()
		end
	end
	local mainFrame = lib.Create("Frame", screenGui, {
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundColor3 = Color3.fromRGB(34, 34, 34), 
		BackgroundTransparency = 0, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0.5, 0,0.5, 0), 
		Size = UDim2.new(0.35, 0,0.35, 0), --UDim2.new(0.35, 0,0.4, 0)
		Active = true,
		Draggable = true,
		Visible = false,
	})
	local mainFrame_corner = lib.Create("UICorner", mainFrame, {
		CornerRadius = UDim.new(0, 5)
	})
	local topBar = lib.Create("Frame", mainFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0, 0,0, 0), 
		Size = UDim2.new(1, 0,0.075, 0),
	})
	local topBar_gradient = lib.Create("UIGradient", topBar, {
		Color = ColorSequence.new(Color3.fromRGB(150, 150, 150), Color3.fromRGB(200, 200, 200));
		Rotation = 270;
		Transparency = NumberSequence.new(0, 1)
	})
	local iconFrame = lib.Create("Frame", topBar, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 1, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0, 0,0, 0), 
		Size = UDim2.new(0.047, 0,1, 0),
	})
	local iconButton = lib.Create("ImageButton", iconFrame, {
		BackgroundTransparency = 1, 
		AnchorPoint = Vector2.new(0.5, 0.5);
		Position = UDim2.new(0.5, 0,0.5, 0),
		Size = UDim2.new(0.512, 0,0.512, 0),
		ScaleType = Enum.ScaleType.Fit;
		Image = Table.Icon or lib.Headshot(Players.LocalPlayer.UserId)
	})
	local closeButton = lib.Create("ImageButton", topBar, {
		AutoButtonColor = false,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.955, 0,0.5, 0), 
		Size = UDim2.new(0.032, 0,0.75, 0),
		ScaleType = "Fit",
		Image = "rbxassetid://7743878857",
		ImageColor3 = Color3.fromRGB(200,200,200)
	})
	local scriptName = lib.Create("TextButton", topBar, {
		AutoButtonColor = false,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0,0.5, 0), 
		Size = UDim2.new(0.15, 0,0.5, 0),
		Font = Enum.Font.SourceSansItalic,
		TextColor3 = Color3.fromRGB(255, 255, 255), 
		Text = Table.ScriptName or "Editor",
		TextScaled = true,
		AutomaticSize = "X",
		TextSize = 16,
		TextXAlignment = "Left",
		TextTransparency = 1,
	})
	local activeFrame = lib.Create("Frame", mainFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0, 0,0.075, 0), 
		Size = UDim2.new(1, 0,0.925, 0),
	})
	local activeFrame_corner = lib.Create("UICorner", activeFrame, {
		CornerRadius = UDim.new(0, 5)
	})
	local sideFrame = lib.Create("Frame", activeFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0, 0,0, 0), 
		Size = UDim2.new(0.225, 0,1, 0),
	})	
	local sideFrame_corner = lib.Create("UICorner", sideFrame, {
		CornerRadius = UDim.new(0, 5)
	})
	local headTextFrame = lib.Create("Frame", sideFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0,0, 0), 
		Size = UDim2.new(1, 0,0.1, 0),
	})
	local headTextButton = lib.Create("TextButton", headTextFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29),
		AnchorPoint = Vector2.new(0, 0.5),
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0,0.5, 0), 
		Size = UDim2.new(1, 0,0.5, 0),
		Font = "GothamMedium",
		TextColor3 = Color3.fromRGB(255, 255, 255), 
		Text = Table.Name or game.Name,
		TextScaled = true,
		TextSize = 20,
		ZIndex = 2,
		ClipsDescendants = true,
	})
	local headTextgradFrame1 = lib.Create("Frame", headTextFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0,0, 0), 
		Size = UDim2.new(1, 0,1, 0),
	})
	local headTextgradFrame2 = lib.Create("Frame", headTextFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0,0, 0), 
		Size = UDim2.new(1, 0,1, 0),
	})
	local headText_grad1 = lib.Create("UIGradient", headTextgradFrame1, {
		Color = ColorSequence.new(Color3.fromRGB(150, 150, 150), Color3.fromRGB(200, 200, 200));
		Rotation = 90;
		Transparency = NumberSequence.new(0, 1)
	})
	local headText_grad2 = lib.Create("UIGradient", headTextgradFrame2, {
		Color = ColorSequence.new(Color3.fromRGB(150, 150, 150), Color3.fromRGB(200, 200, 200));
		Rotation = 270;
		Transparency = NumberSequence.new(0, 1)
	})
	local sideButtonsFrame = lib.Create("ScrollingFrame", sideFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 1, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0, 0,0.1, 0), 
		Size = UDim2.new(1, 0,0.9, 0),
		CanvasSize = UDim2.new(0, 0,1, 0),
		AutomaticCanvasSize = "Y",
		ScrollBarThickness = 0,
	})
	local listlayout_sideButtonsFrame = lib.Create("UIListLayout", sideButtonsFrame, {
		Padding = UDim.new(0, 3),
		SortOrder = "LayoutOrder",
	})
	local sideFramegradient = lib.Create("Frame", sideFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0, 
		BorderSizePixel = 0, 
		Position = UDim2.new(1, 0,0, 0), 
		Size = UDim2.new(0.2, 0,1, 0),
	})
	local sidegradient = lib.Create("UIGradient", sideFramegradient, {
		Color = ColorSequence.new(Color3.fromRGB(150, 150, 150), Color3.fromRGB(200, 200, 200));
		Rotation = 0;
		Transparency = NumberSequence.new(0, 1)
	})

	local tabFrame = lib.Create("Frame", activeFrame, {
		BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
		BackgroundTransparency = 0,
		BorderSizePixel = 0, 
		Position = UDim2.new(0.27, 0,0.1, 0), 
		Size = UDim2.new(0.685, 0,0.85, 0),
	})

	iconButton.MouseEnter:Connect(function()
		lib.Tween(scriptName, "TextTransparency", 0)
	end)
	iconButton.MouseLeave:Connect(function()
		lib.Tween(scriptName, "TextTransparency", 1)
	end)
	closeButton.MouseEnter:Connect(function()
		lib.Tween(closeButton, "ImageColor3", Color3.fromRGB(255,255,255))
	end)
	closeButton.MouseLeave:Connect(function()
		lib.Tween(closeButton, "ImageColor3", Color3.fromRGB(200,200,200))
	end)
	closeButton.MouseButton1Up:Connect(function()
		UILibrary:Destroy()
	end)

	UserInputService.InputBegan:Connect(function(input, gpe)
		if input.KeyCode == mainkey then
			if Table.Hotkey and Table.Hotkey[2] == true then mainFrame.Visible = true return end
			mainFrame.Visible = not mainFrame.Visible
		end	
	end)
	UserInputService.InputEnded:Connect(function(input, gpe)
		if input.KeyCode == mainkey then
			if Table.Hotkey and Table.Hotkey[2] == true then mainFrame.Visible = false return end
		end	
	end)

	iconButton.MouseButton1Down:Connect(function()
		for _, v in pairs(textlog) do
			print(v.Title or "Error", v.Content)
			print(" ")
		end
		UILibrary:Notification({Title = "Console", Content = "[F9] Check Devconsole for script logs", Time = 5})
	end)

	local tabLibrary = {}

	local currentTab
	function tabLibrary:AddTab(Text)
		local tabButtonframe = lib.Create("TextButton", sideButtonsFrame, {
			BackgroundColor3 = Color3.fromRGB(29,29,29), 
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0,0, 0), 
			Size = UDim2.new(1, 0,0.1, 0),
			Text = "",
			AutoButtonColor = false,
		})
		local tabButton = lib.Create("TextButton", tabButtonframe, {
			BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
			AnchorPoint = Vector2.new(0, 0.5),
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0,0.5, 0), 
			Size = UDim2.new(1, 0,0.55, 0),
			Font = "Gotham",
			TextColor3 = Color3.fromRGB(255, 255, 255), 
			Text = Text,
			TextScaled = true,
		})
		local tabButton_highlight = lib.Create("Frame", tabButtonframe, {
			ZIndex = 2,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0,1, 0),
		})
		local tabScrollFrame = lib.Create("ScrollingFrame", tabFrame, {
			BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
			BackgroundTransparency = 0, 
			BorderSizePixel = 0, 
			Position = UDim2.new(0, 0,0, 0), 
			Size = UDim2.new(1, 0,1, 0),
			AutomaticCanvasSize = "Y",
			CanvasSize = UDim2.new(0, 0,1, 0),
			ScrollBarImageTransparency = 1,
			ScrollBarThickness = 1,
			Visible = false,
		})
		local listlayout_tabScrollFrame = lib.Create("UIListLayout", tabScrollFrame, {
			Padding = UDim.new(0, 5),
			SortOrder = "LayoutOrder",
		})

		tabButtonframe.MouseEnter:Connect(function()
			lib.Tween(tabButton_highlight, "BackgroundTransparency", 0.9, "InOut", "Linear", 0.1)
		end)
		tabButtonframe.MouseLeave:Connect(function()
			lib.Tween(tabButton_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
		end)

		local function onToggle()
			for _, v in pairs(sideButtonsFrame:GetChildren()) do
				if v:IsA("TextButton") then
					v.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
				end
			end
			for _, v in pairs(tabFrame:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			tabScrollFrame.Visible = true
			tabButtonframe.BackgroundColor3 = Color3.fromRGB(24, 163, 255)
			currentTab = tabButton
		end

		tabButton.MouseButton1Down:Connect(onToggle)
		tabButtonframe.MouseButton1Down:Connect(onToggle)
		local sectionLibrary = {}

		function sectionLibrary:AddSection(Text)-- fix sections
			local sectionFrame = lib.Create("Frame", tabScrollFrame, {
				BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
				BackgroundTransparency = 1, 
				BorderSizePixel = 1, 
				Position = UDim2.new(0, 0,0, 0), 
				Size = UDim2.new(1, 0,0.105, 0),
				--AutomaticSize = "Y",
				Visible = true, 

			})
			local listlayout_tabScrollFrame = lib.Create("UIListLayout", sectionFrame, {
				Padding = UDim.new(0, 5),
				SortOrder = "LayoutOrder",
			})
			local sectionLabelFrame = lib.Create("Frame", sectionFrame, {
				BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
				AnchorPoint = Vector2.new(0,0),
				BackgroundTransparency = 1, 
				BorderSizePixel = 0, 
				Position = UDim2.new(0, 0,0, 0), 
				Size = UDim2.new(1, 0,1, 0), -- scale y 0.1 
			})
			local sectionlabel = lib.Create("TextLabel", sectionLabelFrame, {
				BackgroundTransparency = 1, 
				AnchorPoint = Vector2.new(0,0.5),
				BorderSizePixel = 0, 
				Position = UDim2.new(0, 0,0.75, 0), 
				Size = UDim2.new(1, 0,0.415, 0),
				Font = "GothamMedium",
				Text = Text,
				TextScaled = true,
				TextColor3 = Color3.fromRGB(155, 155, 155),
				TextXAlignment = "Left",
			})

			local buttonsLibrary = {}

			function buttonsLibrary:AddButton(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.1, 0),
				})
				local Button_highlight = lib.Create("Frame", buttonFrame, {
					ZIndex = 2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
				})
				local buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttontxt = lib.Create("TextButton", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.975, 0,0.55, 0),
					Font = "GothamMedium",
					Text = Table.Text,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
				})
				local button2 = lib.Create("TextButton", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,1, 0),
					Text = "",
				})
				button2.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				button2.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)
				button2.MouseButton1Down:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.9, "InOut", "Linear", 0.01)
				end)
				button2.MouseButton1Up:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.01)
				end)
				button2.Activated:Connect(function()
					local success, err = pcall(function()
						return Table.Callback()
					end)
					if (success) then
						--
					else

						Warn(err)
					end
				end)
				local setLib = {}
				function setLib:Destroy()
					buttonFrame:Destroy()
				end
				function setLib.Text(String)
					buttontxt.Text = String
				end
				return setLib
			end

			function buttonsLibrary:AddLabel(Text)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.1, 0),
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local button = lib.Create("TextLabel", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0.5, 0), 
					Size = UDim2.new(1, 0,0.55, 0),
					Font = "GothamMedium",
					Text = Text,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Center",
				})
				local setLib = {}
				function setLib:Set(value)
					button.Text = value
				end
				return setLib
			end

			function buttonsLibrary:AddParagraph(Text, Text2)
				local paraheader = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.055, 0),
				})
				local buttonFrame_corner = lib.Create("UICorner", paraheader, {
					CornerRadius = UDim.new(0, 5)
				})
				local headerbutton = lib.Create("TextLabel", paraheader, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,1, 0),
					Font = "GothamMedium",
					Text = Text,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
					AutomaticSize = "Y",
				})
				local headerbutton_padding = lib.Create("UIPadding", headerbutton, {
					PaddingTop = UDim.new(0, 0),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingBottom = UDim.new(0, 0),
				})
				local paratext = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.1, 0),
					AutomaticSize = "Y",
				})
				local buttonFrame_corner = lib.Create("UICorner", paratext, {
					CornerRadius = UDim.new(0, 5)
				})
				local button = lib.Create("TextButton", paratext, {
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,1, 0),
					Font = "Gotham",
					Text = Text2,
					TextSize = 12,
					TextColor3 = Color3.fromRGB(150, 150, 150),
					TextXAlignment = "Left",
					AutomaticSize = "Y",
					TextWrapped = true,
				})
				local button_padding = lib.Create("UIPadding", button, {
					PaddingTop = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 10),
					PaddingRight = UDim.new(0, 10),
					PaddingBottom = UDim.new(0, 5),
				})

				button.Activated:Connect(function()
					if typeof(setclipboard) == "function" then
						setclipboard(button.Text)
						UILibrary:Notification({Title = "Console", Content = "content copied to clipboard!"})
					end
				end)

				local setLib = {}
				function setLib:Set(value)
					button.Text = value
				end
				return setLib
			end

			function buttonsLibrary:AddTextBox(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.1, 0),
				})
				local Button_highlight = lib.Create("Frame", buttonFrame, {
					ZIndex = 2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
				})
				local Buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local button = lib.Create("TextButton", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.975, 0,0.55, 0),
					Font = "GothamMedium",
					Text = Table.Text,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
				})
				local box = lib.Create("TextBox", buttonFrame, {
					AnchorPoint = Vector2.new(1, 0.5),
					AutomaticSize = "X",
					BackgroundColor3 = Color3.fromRGB(54, 54, 54), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(1, 0,0.5, 0), 
					Size = UDim2.new(0.15, 0,1, 0),
					ClearTextOnFocus = false,
					Font = "GothamMedium",
					Text = Table.Default or "Default",
					PlaceholderText = "Enter value",
					TextScaled = true,
					TextColor3 = Color3.fromRGB(155, 155, 155),
					PlaceholderColor3 = Color3.fromRGB(155, 155, 155),
				})
				local box_corner = lib.Create("UICorner", box, {
					CornerRadius = UDim.new(0, 5)
				})
				local box_padding = lib.Create("UIPadding", box, {
					PaddingTop = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 8),
					PaddingBottom = UDim.new(0, 5),
				})
				button.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				button.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)
				button.MouseButton1Down:Connect(function()
					box:CaptureFocus()
				end)
				box.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLost)
					if not enterPressed then return end
					local success, err = pcall(function()
						return Table.Callback(box.Text)
					end)
					if (success) then
						--
					else
						Warn(err)
					end
				end)
				local setLib = {}
				function setLib:Set(value)
					box.Text = value
				end
				function setLib:Destroy()
					buttonFrame:Destroy()
				end
				return setLib
			end

			function buttonsLibrary:AddToggle(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.125, 0),
				})
				local Button_highlight = lib.Create("Frame", buttonFrame, {
					ZIndex = 2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
				})
				local Buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local label = lib.Create("TextLabel", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0,  
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.975, 0,0.455, 0),
					Font = "GothamMedium",
					Text = Table.Text,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
					ZIndex = 2,
				})
				local button = lib.Create("TextButton", buttonFrame, {
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					--Position = UDim2.new(0, 0,0, 0), 
					Position = UDim2.new(0.985, 0,0.5, 0), 
					--Size = UDim2.new(1, 0,1, 0),
					Size = UDim2.new(0.063, 0,0.65, 0),
					Text = "",
				})
				local button2 = lib.Create("TextButton", buttonFrame, {
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,1, 0),
					Text = "",
				})
				local button_corner = lib.Create("UICorner", button, {
					CornerRadius = UDim.new(0, 5)
				})
				--local button_gradient = lib.Create("UIGradient", button, {
				--	Rotation = 180;
				--	Transparency = NumberSequence.new(0, 1)
				--})
				buttonFrame.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				buttonFrame.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)
				local Toggle = Table.Default or false

				if Table.Key then
					Keys[Table.Key] = {}
					Keys[Table.Key]["Value"] = Table.Default or false
					Toggle = Keys[Table.Key].Value
				end

				if (Table.Default) then
					button.BackgroundColor3 = Color3.fromRGB(85, 170, 127)
				else
					button.BackgroundColor3 = Color3.fromRGB(227, 67, 67)
				end

				local function onActivate()

					if (Toggle) then			
						Toggle = false
						if Table.Key then
							Keys[Table.Key].Value = Toggle
							if config.Save then Sync(1, {Table.Key, "false"}) end
						end
						lib.Tween(button, "BackgroundColor3", Color3.fromRGB(227, 67, 67), "InOut", "Linear", 0.1)
					elseif not (Toggle) then
						Toggle = true
						if Table.Key then
							Keys[Table.Key].Value = Toggle
							if config.Save then Sync(1, {Table.Key, "true"}) end
						end
						lib.Tween(button, "BackgroundColor3", Color3.fromRGB(85, 170, 127), "InOut", "Linear", 0.1)
					end
					local success, err = pcall(function()
						return Table.Callback(Toggle)
					end)
					if (success) then
						--
					else
						Warn(err)
					end
				end
				button.Activated:Connect(function()
					onActivate()
				end)
				button2.Activated:Connect(function()
					onActivate()
				end)
				local function Boolean(x)
					if x == "true" then
						return true
					elseif x == false then
						return false
					end
				end
				local setLib = {}
				function setLib:Set(value)
					Toggle = not value
					onActivate()
				end
				if config.Save then
					local bool = Sync(0, {Table.Key, tostring(Table.Default)})
					setLib:Set(Boolean(bool))
				end
				function setLib:Destroy()
					buttonFrame:Destroy()
				end
				return setLib

			end

			function buttonsLibrary:AddSlider(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.2, 0),
				})
				local Button_highlight = lib.Create("Frame", buttonFrame, {
					ZIndex = 2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
				})
				local Buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local button = lib.Create("TextButton", buttonFrame, {
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(50, 50, 50), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.025, 0,0.25, 0), 
					Size = UDim2.new(0.975, 0,0.25, 0),
					Text = Table.Text,
					Font = "GothamMedium",
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
				})
				local maxFrame = lib.Create("Frame", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255), 
					BackgroundTransparency = 0.95, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.95, 0,0.35, 0),
				})
				local buttonFrame_corner = lib.Create("UICorner", maxFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local slider = lib.Create("Frame", maxFrame, {
					BackgroundColor3 = Table.Color or Color3.fromRGB(85, 170, 255), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(0.7, 0,1, 0),
				})
				local buttonFrame_corner = lib.Create("UICorner", slider, {
					CornerRadius = UDim.new(0, 5)
				})
				local label = lib.Create("TextLabel", maxFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0.5, 0), 
					Size = UDim2.new(1, 0,0.85, 0),
					Font = "GothamMedium",
					Text = Table.Default or Table.Min,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					ZIndex = 2,
				})

				button.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				button.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)

				local mouse = Players.LocalPlayer:GetMouse()
				local current = Table.Default or Table.Min
				local default = current/Table.Max

				if Table.Key then
					Keys[Table.Key] = {}
					Keys[Table.Key]["Value"] = current
				end

				slider.Size = UDim2.new(default, 0,1, 0)
				local dragging = false

				local function update(value)
					local int = math.floor(value * Table.Max)
					label.Text = tostring(int)
					if Table.Key then
						Keys[Table.Key].Value = int
					end
					return Table.Callback(int)
				end

				maxFrame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						mainFrame.Draggable = false
						mainFrame.Active = false
						dragging = true
					end
				end)
				maxFrame.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						mainFrame.Draggable = true
						mainFrame.Active = true
						dragging = false
					end
				end)

				maxFrame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						mainFrame.Draggable = false
						mainFrame.Active = false
						local pos = UDim2.new(math.clamp((mouse.X - maxFrame.AbsolutePosition.X) / maxFrame.AbsoluteSize.X, 0, 1), 0, 1, 0)
						slider:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1, true, update(pos.X.Scale))
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local pos = UDim2.new(math.clamp((mouse.X - maxFrame.AbsolutePosition.X) / maxFrame.AbsoluteSize.X, 0, 1), 0, 1, 0)
						slider:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1, true, update(pos.X.Scale))
					end
				end)

				local setLib = {}
				function setLib:Set(value)
					local change = tonumber(value)/Table.Max
					slider.Size = UDim2.new(change, 0,1, 0)
					update(change)
				end
				function setLib:Destroy()
					buttonFrame:Destroy()
				end
				return setLib

			end

			function buttonsLibrary:AddDropDown(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.1, 0),
					ZIndex = 1
				})
				local Button_highlight = lib.Create("Frame", buttonFrame, {
					ZIndex = 1,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
				})
				local Buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local button_ = lib.Create("TextButton", buttonFrame, {
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(50, 50, 50), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.025, 0,0.5, 0),
					Size = UDim2.new(0.975, 0,0.55, 0),
					Text = Table.Text,
					Font = "GothamMedium",
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
					ZIndex = 1
				})
				local button = lib.Create("TextButton", buttonFrame, {
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(0, 0),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0),
					Size = UDim2.new(1, 0,1, 0),
					Text = "",
					ZIndex = 2
				})
				local displayopt = lib.Create("TextLabel", buttonFrame, {
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(1, 0.5),
					AutomaticSize = "X",
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.925, 0,0.5, 0),
					Size = UDim2.new(0, 0,0.45, 0),
					Text = "",
					ZIndex = 1,
					TextColor3 = Color3.fromRGB(155,155,155),
					Font = "GothamMedium",
					TextScaled = true,
					TextXAlignment = "Left",
					Name = "DisplayOpt"
				})
				local imageFrame = lib.Create("Frame", buttonFrame, {
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.927, 0,0, 0), 
					Size = UDim2.new(0.072, 0,1, 0),
					ZIndex = 2
				})
				local imagebutton = lib.Create("ImageButton", imageFrame, {
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.1, 0,0.1, 0), 
					Size = UDim2.new(0.8, 0,0.8, 0),
					ScaleType = Enum.ScaleType.Fit;
					Image = "rbxassetid://11563616615",
					ZIndex = 2
				})
				local optionsFrame = lib.Create("Frame", buttonFrame, {
					BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,1, 0), 
					Size = UDim2.new(1, 0,1, 0),
					ZIndex = 5,
					Visible = false,
				})
				local uilistlayout_optionsFrame = lib.Create("UIListLayout", optionsFrame, {
					SortOrder = "LayoutOrder",
					HorizontalAlignment = "Right",
				})
				buttonFrame.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				buttonFrame.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)
				local function createOpt(t)
					if typeof(t) == "Instance" then
						t = t.Name
					else
						t = t
					end
					local buttonFrame = lib.Create("Frame", optionsFrame, {
						BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
						BackgroundTransparency = 0, 
						BorderSizePixel = 0, 
						Position = UDim2.new(0, 0,0, 0), 
						Size = UDim2.new(1, 0,0.8, 0),
						ZIndex = 5
					})
					local button = lib.Create("TextButton", buttonFrame, {
						AutoButtonColor = false,
						AnchorPoint = Vector2.new(0.5,0.5),
						BackgroundColor3 = Color3.fromRGB(50, 50, 50), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						Position = UDim2.new(0.515, 0,0.5, 0), 
						Size = UDim2.new(0.975, 0,0.55, 0),
						Text = t  ,
						Font = "GothamMedium",
						TextScaled = true,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextXAlignment = "Left",
						ZIndex = 5
					})

					if Table.Key then
						Keys[Table.Key] = {}
						Keys[Table.Key]["Options"] = Table.Options
					end

					return button
				end

				local show = false

				local function onActivate(v)
					optionsFrame.Visible = false
					show = false
					lib.Tween(imagebutton, "Rotation", 0)
					local success, err = pcall(function()
						if typeof(v) == "Instance" then
							v = v.Name
						else
							v = v
						end
						return Table.Callback(v)
					end)
					if (success) then
						displayopt.Text = v or v.Name
					else
						Warn(err)
					end
				end

				if Table.Default and not Table.Options then
					local newOp = createOpt(Table.Default)
					newOp.Activated:Connect(function()
						onActivate(Table.Default)
					end)
				else
					for _, v in pairs(Table.Options) do
						local newOp = createOpt(v)
						newOp.Activated:Connect(function()
							onActivate(v)
						end)
					end
				end

				local function toggleOpt()
					if (show) then
						lib.Tween(imagebutton, "Rotation", 0)
						optionsFrame.Visible = false
						show = false
					elseif not (show) then
						lib.Tween(imagebutton, "Rotation", -180)
						optionsFrame.Visible = true
						show = true
					end
				end
				imagebutton.MouseButton1Down:Connect(toggleOpt)
				button.MouseButton1Down:Connect(toggleOpt)

				local setLib = {}
				function setLib:Set(v)
					onActivate(v)
				end
				function setLib:Destroy()
					buttonFrame:Destroy()
				end
				function setLib:Refresh(upTable, boolean)
					if boolean then
						table.clear(Table.Options)
						Table.Options = upTable
						for _, v in pairs(optionsFrame:GetChildren()) do
							if v:IsA("Frame") then
								v:Destroy()
							end
						end
						for _, v in pairs(Table.Options) do
							local newOp = createOpt(v)
							newOp.Activated:Connect(function()
								onActivate(v)
							end)
						end
					else
						for _, v in pairs(upTable) do
							table.insert(Table.Options, v)
						end

						for _, v in pairs(optionsFrame:GetChildren()) do
							if v:IsA("Frame") then
								v:Destroy()
							end
						end
						for _, v in pairs(Table.Options) do
							local newOp = createOpt(v)
							newOp.Activated:Connect(function()
								onActivate(v)
							end)
						end
					end

				end

				return setLib

			end

			function buttonsLibrary:AddBind(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.1, 0),
				})
				local Button_highlight = lib.Create("Frame", buttonFrame, {
					ZIndex = 2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
				})
				local Buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local labelbutton = lib.Create("TextButton", buttonFrame, {
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(50, 50, 50),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.975, 0,0.55, 0),
					Text = Table.Text,
					Font = "GothamMedium",
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
				})
				local InputButton = lib.Create("TextButton", buttonFrame, {
					AnchorPoint = Vector2.new(1, 0.5),
					AutomaticSize = "X",
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(54, 54, 54), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(1, 0,0.5, 0), 
					Size = UDim2.new(0.072, 0,1, 0),
					Text = Table.Default.Name,
					Font = "GothamMedium",
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
				})
				local InputButton_corner = lib.Create("UICorner", InputButton, {
					CornerRadius = UDim.new(0, 5)
				})
				local InputButton_padding = lib.Create("UIPadding", InputButton, {
					PaddingTop = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 8),
					PaddingBottom = UDim.new(0, 5),
				})

				labelbutton.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				labelbutton.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)

				local key = Table.Default
				local focus = false

				if Table.Key then
					Keys[Table.Key] = {}
					Keys[Table.Key]["Value"] = Table.Default
				end

				InputButton.Activated:Connect(function()
					focus = true
					InputButton.Text = "..."
				end)
				UserInputService.InputEnded:Connect(function(input, gpe)
					if not focus and input.KeyCode == key then
						local success, err = pcall(function()
							return Table.Callback(key)
						end)
						if (success) then
							--
						else
							Warn(err)
						end
					end
					if focus and input.UserInputType == Enum.UserInputType.Keyboard then
						key = input.KeyCode
						focus = false
						InputButton.Text = key.Name
						if Table.Key then
							Keys[Table.Key].Value = key
						end
					end

				end)

				local setLib = {}
				function setLib:Set(value)
					key = value
					if Table.Key then
						Keys[Table.Key].Value = key
					end
					InputButton.Text = key.Name
				end
				function setLib:Destroy()
					buttonFrame:Destroy()
				end
				return setLib

			end

			function buttonsLibrary:AddColorPicker(Table)
				local buttonFrame = lib.Create("Frame", tabScrollFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,0.115, 0),
				})
				
				local buttonFrame_corner = lib.Create("UICorner", buttonFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local frame_uilistlayout = lib.Create("UIListLayout", buttonFrame, {
					SortOrder = "Name",
					FillDirection = "Vertical",
				})

				local topFrame = lib.Create("Frame", buttonFrame, {
					AutomaticSize = "Y",
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 0.95, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,1, 0), -- offset
					Name = "1"
				})
				local Button_highlight = lib.Create("Frame", topFrame, {
					ZIndex = 2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0,1, 0),
					--Visible = false,
				})
				local Buttonhighlight_corner = lib.Create("UICorner", Button_highlight, {
					CornerRadius = UDim.new(0, 5)
				})
				local topFrame_corner = lib.Create("UICorner", topFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local Display = lib.Create("TextButton", topFrame, {
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.975, 0,0.5, 0), 
					Size = UDim2.new(0.063, 0,0.65, 0),
					Text = "",
					ZIndex = 2,
				})
				local Display_corner = lib.Create("UICorner", Display, {
					CornerRadius = UDim.new(0, 5)
				})
				local label = lib.Create("TextLabel", topFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, 
					BorderSizePixel = 0,  
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.975, 0,0.425, 0),
					Font = "GothamMedium",
					Text = Table.Text,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = "Left",
					ZIndex = 1,
				})
				local active = lib.Create("TextButton", topFrame, {
					BackgroundColor3 = Color3.fromRGB(44, 44, 44), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0,  
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,1, 0),
					Text = "",
					ZIndex = 2,
				})
				local bottomFrame = lib.Create("Frame", buttonFrame, {
					AutomaticSize = "Y",
					BackgroundColor3 = Color3.fromRGB(54, 54, 54), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0,0, 0), 
					Size = UDim2.new(1, 0,2.5, 0), -- offset, scale y = 2.5
					Name = "2",
					Visible = false
				})
				local bottomFrame_corner = lib.Create("UICorner", bottomFrame, {
					CornerRadius = UDim.new(0, 5)
				})
				local Hue = lib.Create("Frame", bottomFrame, {
					AutomaticSize = "Y",
					AnchorPoint = Vector2.new(1,0.5),
					BackgroundColor3 = Color3.fromRGB(163, 162, 165), 
					BackgroundTransparency = 0, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0.975, 0,0.5, 0), 
					Size = UDim2.new(0.063, 0,0.8, 0), -- offset, scale y = 2.5
				})
				local HueSelection = lib.Create("Frame", Hue, {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0,
					BackgroundTransparency = 0.75,
					Position = UDim2.new(0.5, 0,0, 0), 
					Size = UDim2.new(1.15, 0,0, 2),
				})
				local Slider_corner = lib.Create("UICorner", Hue, {
					CornerRadius = UDim.new(0, 5)
				})
				local Slider_gradient = lib.Create("UIGradient", Hue, {
					Rotation = 270, 
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))}
				})
				local Color = lib.Create("ImageLabel", bottomFrame, {
					AnchorPoint = Vector2.new(0, 0.5),
					BorderSizePixel = 0,
					Position = UDim2.new(0.025, 0,0.5, 0), 
					Size = UDim2.new(0.875, 0,0.8, 0),
					ScaleType = "Stretch",
					Image = "rbxassetid://4155801252",
				})
				local ColorSelection = lib.Create("ImageLabel", Color, {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0, 0), 
					Size = UDim2.new(0, 5,0, 5),
					ScaleType = "Fit",
					Image = "rbxassetid://6755657357",
				})
				local Saturation_corner = lib.Create("UICorner", Color, {
					CornerRadius = UDim.new(0, 5)
				})

				-- Messy way to convert to offset because AutomaticSize doesn't work properly for scale
				buttonFrame.Size = UDim2.new(1,0,0,buttonFrame.AbsoluteSize.Y)
				topFrame.Size = UDim2.new(1,0,0,topFrame.AbsoluteSize.Y)
				active.Size = UDim2.new(1,0,0,topFrame.AbsoluteSize.Y)
				bottomFrame.Size = UDim2.new(1,0,0,bottomFrame.AbsoluteSize.Y)
				buttonFrame.AutomaticSize = "Y"
				local bottomFrameNewSize = bottomFrame.AbsoluteSize.Y
				bottomFrame.Size = UDim2.new(1,0,0,0)
				
				topFrame.MouseEnter:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 0.95, "InOut", "Linear", 0.1)
				end)
				topFrame.MouseLeave:Connect(function()
					lib.Tween(Button_highlight, "BackgroundTransparency", 1, "InOut", "Linear", 0.1)
				end)
				
				local tempTog = false
				active.MouseButton1Down:Connect(function()
					if not tempTog then
						lib.Tween(bottomFrame, "Size", UDim2.new(1,0,0, bottomFrameNewSize), "InOut", "Quad")
						bottomFrame.Visible = true
						Button_highlight.Visible = false
						tempTog = true
					else
						lib.Tween(bottomFrame, "Size", UDim2.new(1,0,0, 0), "InOut", "Quad")
						wait(0.1)
						bottomFrame.Visible = false
						Button_highlight.Visible = true
						tempTog = false
					end
				end)

				local Mouse = game.Players.LocalPlayer:GetMouse()
				local ColorH, ColorS, ColorV = 1, 1, 1
				local Colorpicker = {Value = Table.Default or Color3.fromRGB(255, 255, 127)}
				if Table.Key then
					Keys[Table.Key] = {}
					Keys[Table.Key]["Value"] = Colorpicker.Value
				end
				function Colorpicker:Set(Value)
					Colorpicker.Value = Value
					Display.BackgroundColor3 = Colorpicker.Value
					Table.Callback(Display.BackgroundColor3)
					if Table.Key then
						Keys[Table.Key].Value = Colorpicker.Value
					end
				end
				local function UpdateColorPicker()
					Display.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
					Colorpicker:Set(Display.BackgroundColor3)
					--Table.Callback(Display.BackgroundColor3)
				end 
				ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
				ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
				ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
				local dragging
				Color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						mainFrame.Draggable = false
						mainFrame.Active = false
					end
				end)
				Color.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
						mainFrame.Draggable = true
						mainFrame.Active = true
					end
				end)

				Color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
						local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
						ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
						ColorS = ColorX
						ColorV = 1 - ColorY
						UpdateColorPicker()
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
						local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
						ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
						ColorS = ColorX
						ColorV = 1 - ColorY
						UpdateColorPicker()
					end
				end)
				local dragging2
				Hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging2 = true
						mainFrame.Draggable = false
						mainFrame.Active = false
					end
				end)
				Hue.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging2 = false
						mainFrame.Draggable = true
						mainFrame.Active = true
					end
				end)

				Hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)

						HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
						ColorH = 1 - HueY

						UpdateColorPicker()
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if dragging2 and input.UserInputType == Enum.UserInputType.MouseMovement then
						local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)

						HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
						ColorH = 1 - HueY

						UpdateColorPicker()
					end
				end)
				Colorpicker:Set(Colorpicker.Value)
				local setLib = {}
				function setLib:Set(Value)
					Colorpicker:Set(Value)
				end
				return setLib
				
			end

			return buttonsLibrary

		end

		return sectionLibrary

	end
	mainFrame.Visible = true
	Sys('<font color="rgb(85, 170, 127)">Loaded!</font>', "["..cache.HubName.."] "  .. cache.ScriptName .. " by " .. cache.Creator .. ", press '" ..  cache.Hotkey .. "' to toggle UI.")
	return tabLibrary

end

function UILibrary:Notification(Table)
	spawn(function()
		for _, v in pairs(instanceLog) do
			if v:IsA("Frame") then

				v:Destroy()
			end
		end
		local function gen()
			local frame = lib.Create("Frame", screenGui, {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(34,34,34),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5,0,1.05,0),
				Size = UDim2.new(0.45,0,0.05,0),
				ClipsDescendants = true,
			})
			local frame_corner = lib.Create("UICorner", frame, {
				CornerRadius = UDim.new(0, 5)
			})
			local frame_stroke = lib.Create("UIStroke", frame, {
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(0,0,0),
				Thickness = 3,
				Transparency = 0.75,
			})
			local frame_uilistlayout = lib.Create("UIListLayout", frame, {
				SortOrder = "LayoutOrder",
				FillDirection = "Horizontal"
			})
			local title = lib.Create("TextButton", frame, {
				BackgroundColor3 = Color3.fromRGB(29, 29, 29), 
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 1,
				Position = UDim2.new(0, 0,0, 0), 
				Size = UDim2.new(0.05, 0,1, 0),
				Font = "GothamMedium",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				RichText = true,
				Text = Table.Title or '<font color="rgb(227, 67, 67)">Error</font>',
				TextSize = 16,
				AutomaticSize = "X"
			})
			local title_padding = lib.Create("UIPadding", title, {
				PaddingLeft = UDim.new(0, 10),
			}) 
			local content = lib.Create("TextButton", frame, {
				AutomaticSize = "X",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255), 
				BackgroundTransparency = 1, 
				BorderSizePixel = 1, 
				Position = UDim2.new(0, 0,0, 0), 
				Size = UDim2.new(0.05, 0,1, 0),
				Font = "Gotham",
				Text = Table.Content,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				RichText = true,
			})
			local content_padding = lib.Create("UIPadding", content, {
				PaddingLeft = UDim.new(0, 15),
			})
			return frame, frame_stroke, title, content
		end

		local delay_ = Table.Time or 5

		local frame, frame_stroke, title, content = gen()

		content.Activated:Connect(function()
			if typeof(setclipboard) == "function" then
				setclipboard(content.Text)
				UILibrary:Notification({Title = "Console", Content = "content copied to clipboard!"})
			else
				for _, v in pairs(textlog) do
					print(v.Title or "Error", v.Content)
					print(" ")
				end
				UILibrary:Notification({Title = "Console", Content = "[F9] Check Devconsole for script logs"})
			end
		end)

		table.insert(instanceLog, frame)
		table.insert(textlog, Table)
		lib.Tween(frame, "Position", UDim2.new(0.5,0,0.85,0), "InOut", "Back", 0.25)
		wait(delay_)
		lib.Tween(frame, "Transparency", 1, "InOut", "Linear", delay_)
		lib.Tween(frame_stroke, "Transparency", 1, "InOut", "Linear", delay_)
		lib.Tween(title, "TextTransparency", 1, "InOut", "Linear", delay_)
		lib.Tween(content, "TextTransparency", 1, "InOut", "Linear", delay_)
		wait(delay_)
		frame:Destroy()
	end)
end

function Warn(err)
	UILibrary:Notification({
		Content = err,
	})
end
function Sys(Title, Content, Time)
	UILibrary:Notification({
		Title = Title,
		Content = Content,
		Time = Time or 5
	})
end

function UILibrary:Get(str)
	if not Keys[str] then Warn("Key : " .. str .. " not found.") return end
	local toReturn
	if Keys[str].Options then
		toReturn = Keys[str].Options
	else
		toReturn = Keys[str].Value
	end
	return toReturn
end

return UILibrary
