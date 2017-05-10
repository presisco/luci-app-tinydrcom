--[[
Author:superlc
Modifier:presisco
]]--

module("luci.controller.tinydrcom", package.seeall)

function index()
	local page
	page=entry({"admin", "services", "tinydrcom"}, cbi("tinydrcom"), _("TinyDrcom"))
	page.dependent = true
end