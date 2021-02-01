local class_mt = {}

function class_mt:__index(key)
	if rawget(self, "__baseclass") then
		return self.__baseclass[key]
	end
	return nil
end

function class_mt:__call(...)
	return self:new(...)
end

function class_mt:__add(parent)
	return self:addparent(parent)
end

function class_mt:__eq(other)
	if not other.__baseclass or other.__baseclass ~= self.__baseclass then return false end
	for i, v in pairs(self) do
		if not other[i] then
			return false
		end
	end
	for i, v in pairs(other) do
		if not self[i] then
			return false
		end
	end
	return true
end

function class_mt:__lt(other)
	if not other.__baseclass then return false end
	if rawget(other.__baseclass, "__isparenttable") then
		for i, v in pairs(other.__baseclass) do
			if self == v or getmetatable(self).__lt(self, v) then return true end
		end
	else
		if self == other.__baseclass or getmetatable(self).__t(self, other.__baseclass) then return true end
	end
	return false
end

function class_mt:__le(other)
	return (self < other or self == other)
end

local pt_mt = {}
function pt_mt:__index(key)
	for i, v in pairs(self) do
		if i ~= "__isparenttable" and v[key] then
			return v[key]
		end
	end
	return nil
end

class = setmetatable({ __baseclass = {} }, class_mt)

function class:new(...)
	local c = {}
	c.__baseclass = self
	setmetatable(c, getmetatable(self))
	if c.init then
		c:init(...)
	end
	return c
end

function class:convert(t)
	t.__baseclass = self
	setmetatable(t, getmetatable(self))
	return t
end

function class:addparent(...)
	if not rawget(self.__baseclass, "__isparenttable") then
		local t = {__isparenttable = true, self.__baseclass, ...}
		self.__baseclass = setmetatable(t, pt_mt)
	else
		for i, v in ipairs{...} do
			table.insert(self.__baseclass, v)
		end
	end
	return self
end

function class:setmetamethod(name, value)
	local mt = getmetatable(self)
	local newmt = {}
	for i, v in pairs(mt) do
		newmt[i] = v
	end
	newmt[name] = value
	setmetatable(self, newmt)
end

return class
