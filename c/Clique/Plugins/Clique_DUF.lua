--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("duf")
Plugin.fullname = "Discord Unit Frames"
Plugin.url = "http://www.wowinterface.com/downloads/info4177-Discord_Unit_Frames.html"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return DUF_UnitFrame_OnClick
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    self:Hook("DUF_UnitFrame_OnClick", "DUFClick")
    self:Hook("DUF_Element_OnClick", "DUFEClick")
end

function Plugin:DUFClick(button)
    if not Clique:OnClick(button, this.unit) then
        return self.hooks.DUF_UnitFrame_OnClick.orig(button)
    end
end

function Plugin:DUFEClick(button)
    if not Clique:OnClick(button, this.unit) then
        return self.hooks.DUF_Element_OnClick.orig(button)
    end
end