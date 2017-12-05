--
-- Copyright (c) 2017 Milos Tosic. All rights reserved.
-- License: http://www.opensource.org/licenses/BSD-2-Clause
--

local params		= { ... }
local TBB_ROOT		= params[1]

local TBB_INC  		= TBB_ROOT .. "include/"
local TBB_SRC 		= TBB_ROOT .. "src/"

local TBB_FILES = {
	TBB_INC .. "**h",
	TBB_SRC .. "tbb/**.cpp",
	TBB_SRC .. "tbb/**.h",
--	TBB_SRC .. "tbbmalloc/**.cpp",
--	TBB_SRC .. "tbbmalloc/**.h",
--	TBB_SRC .. "rml/**.cpp",
--	TBB_SRC .. "rml/**.h"
}

local TBB_INCLUDES = {
	TBB_INC,
	TBB_SRC,
	TBB_SRC .. "test/",
	TBB_SRC .. "rml/include/"
}

local TBB_DEFINES = {
	"__TBB_PERF_API=",
	"TBB_PREVIEW_GLOBAL_CONTROL=1"
}

function tbb_extraConfig()
	forcedincludes {"algorithm"}	-- min/max
	if getTargetOS() == "windows" then
		defines { "USE_WINTHREAD=1" }
		includedirs { TBB_ROOT .. "build/vs2013/" }
	else
		defines { "USE_PTHREAD=1" }
	end
end 

function projectAdd_tbb()
	addProject_3rdParty_lib("tbb", TBB_FILES, true, TBB_INCLUDES, TBB_DEFINES, tbb_extraConfig)
end

