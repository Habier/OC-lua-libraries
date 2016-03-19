--
--Manage a collection of documents.
--You will need to create '/yourPath/data/' yourself
--to load it use 'collection.load("yourPath/data")'

local fs=require("filesystem")
local serialization=require("serialization")

local c={}
c.metaData={}

function c.saveMeta() --saves management data
	local file=io.open(c.metaFile,'w')
	file:write(serialization.serialize(c.metaData))
	file:close()
end

function c.load(path)
	c.metaFile=path.."/meta.dat"
	c.dataPath=path.."/data/"
	
	if not fs.isDirectory(c.dataPath) then
		fs.makeDirectory(c.dataPath)
	end
	
	
	if not fs.exists(c.metaFile) then
		c.metaData.size=0
		c.saveMeta()
		return
	end
	
	local file=io.open(c.metaFile,'r')
	local aux = file:read()
	file:close()
	c.metaData= serialization.unserialize(aux)
end

function c.saveDoc(doc) --saves the doc in the hardrive
	if doc._id == nil then -- No _id specified
		c.metaData.size=metaData.size+1
		doc._id = metaData.size
		saveMeta()
	end
	
	local file=io.open(c.getDocPath(doc._id),'w')
	file:write(serialization.serialize(doc))
	file:close()
end

function c.getDocPath(n)
	return c.dataPath..n
end

function c.delete(n)
	fs.remove(c.getDocPath(n))
end

function c.getDoc(n)
	local path=c.getDocPath(n)
	
	if fs.exists(path) == false then
		return nil
	end
	
	local file=io.open(path,'r')
	local userData = file:read()
	file:close()
	return serialization.unserialize(userData)
end

return c -- END