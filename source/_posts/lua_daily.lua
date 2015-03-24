local function test_no_return() return "123" end
local a = test_no_return()
print(a)

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function string.ends(String,End)
   return End=='' or string.sub(String,-string.len(End))==End
end

local kk = string.ends("String", "")
print(kk)

local str = "aaaaaa aaaa"
str = str:gsub("^%l", string.upper)
print("str", str)