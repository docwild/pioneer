-- Copyright © 2008-2013 Pioneer Developers. See AUTHORS.txt for details
-- Licensed under the terms of the GPL v3. See licenses/GPL-3.txt

local ui = Engine.ui
local l = Lang.GetDictionary()

local return_to_menu = ui:Button():SetInnerWidget(ui:Label(l.RETURN_TO_MENU))
return_to_menu.onClick:Connect(function () ui:SetInnerWidget(ui.templates.MainMenu()) end)



ui.templates.Settings = function (args) 
	local gameTemplate = function()
	return ui:VBox():PackEnd({
		ui:HBox():PackEnd({
			ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:CheckBox(), ui:Label("Game Test"),
			})),
			ui:Margin(5),
			ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:CheckBox(), ui:Label("Game Test2"),
			}))
		})
	})
	end
	local modeTable = Settings:GetVideoModes()
	local iniTable = Settings:GetGameConfig()
	
	local detailLevel = {"Low", "Medium", "High"}
	local detailDropDown = ui:DropDown()
	for i = 1,#detailLevel do detailDropDown:AddOption(detailLevel[i]) end
	detailDropDown.onOptionSelected:Connect(function() local option = detailDropDown.selectedOption
						print(option) end)
	
	local fullScreenCheckBox = ui:CheckBox()
	local shadersCheckBox = ui:CheckBox()
	local compressionCheckBox = ui:CheckBox()
	local screenModeList = ui:DropDown()
	for i = 1,#modeTable do screenModeList:AddOption(modeTable[i]) end
	--   print ("option = ", screenModeList.selectedOption)
	screenModeList:SetOption(iniTable["ScrWidth"].."x"..iniTable["ScrHeight"]);
	print ("option = ", screenModeList.selectedOption)
	screenModeList.onOptionSelected:Connect(function() local option = screenModeList.selectedOption
						
						print (option) end)
	fullScreenCheckBox:SetState(iniTable["StartFullscreen"])
	compressionCheckBox:SetState(iniTable["UseTextureCompression"])
	shadersCheckBox:SetState(iniTable["DisableShaders"])


						
	local videoTemplate = function()
	return ui:Grid({1,2,1}, 1)
		:SetCell(1,0,
			ui:Scroller():SetInnerWidget(ui:VBox():PackEnd({
			ui:Background():SetInnerWidget( ui:HBox(5):PackEnd({ui:Label("Screen Mode"),screenModeList})),
			ui:Margin(5),
			ui:Background():SetInnerWidget( ui:HBox(5):PackEnd({ui:Label("Detail Level"),detailDropDown})),
			ui:Margin(5),
			ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:Label("Full Screen"), fullScreenCheckBox})),
			ui:Margin(5),
			ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:Label("Compress Textures"), compressionCheckBox})),
			ui:Margin(5),
			ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:Label("Disable Shaders"), shadersCheckBox})),
			ui:Margin(5),
		}))
	)
	
	end
	
	local masterVolume = ui:Adjustment("Master Volume ")
	masterVolume:SetScrollPosition(iniTable["MasterVolume"]);
	local musicVolume = ui:Adjustment("Music Volume ")
	musicVolume:SetScrollPosition(iniTable["MusicVolume"]);
	local lab = ui:Label("a")
	masterVolume.OnChange:Connect(function() local pos = masterVolume.ScrollPosition lab:SetText(pos) end )
	local soundTemplate = function()	
		return ui:Grid({1,2,1}, 2)
		:SetCell(1,0,masterVolume) 
		:SetCell(2,0,lab) 
		:SetCell(1,1,musicVolume)
	end
	local languageTemplate = function()
	return ui:VBox():PackEnd({
		ui:HBox():PackEnd({
			ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:CheckBox(), ui:Label("Language Test"),
					})),
					ui:Margin(5),
					ui:Background():SetInnerWidget(ui:HBox(5):PackEnd({ui:CheckBox(), ui:Label("Language Test2"),
			                                                                   }))
		})
	})
	end
	local setTabs = UI.TabGroup.New()
	setTabs:AddTab({ id = "Game",        title = l.GAME,     icon = "GameBoy", template = gameTemplate         })
	setTabs:AddTab({ id = "Video",        title = l.VIDEO,     icon = "VideoCamera", template = videoTemplate         })
	setTabs:AddTab({ id = "Sound",        title = l.SOUND,     icon = "Speaker", template = soundTemplate         })
	setTabs:AddTab({ id = "Language",        title = l.LANGUAGE,     icon = "Globe1", template = languageTemplate         })
	local settings =
	ui:Background():SetInnerWidget(ui:Margin(30):SetInnerWidget(
		ui:VBox(10):PackEnd({
			setTabs.widget,
			return_to_menu
			
		})
	))  

	--   print("videotable", #modeTable)
	--   print ("iniTable", #iniTable)
	--   print("BindViewForward", iniTable["BindViewForward"])
	--   local i = 0
	--   for x,y in pairs(iniTable) do
	--     i = i +1
	--   end
	--   print("counted number: ", i)
	return settings
end
