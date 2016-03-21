--
--Code for a fifo queu
--use it in your code as 'local queue = require("queue")'
--
local fifo = {}

function fifo.new ()
	fifo.first = 0
	fifo.last = -1
	fifo.q={}
end

function fifo.isEmpty()
	if fifo.first > fifo.last then
		return true
	end
	return false
end
    
	-- Maybe needs to stop listener before calling and re-enable it after
function fifo.push (t)
	local last = fifo.last + 1
	fifo.last = last
	fifo.q[last] = t
end
    
function fifo.pop ()
	if fifo.first > fifo.last then 
		error("queu is empty")
	end
	local value = fifo.q[fifo.first]
	fifo.q[fifo.first] = nil	-- to allow garbage collection
	fifo.first = fifo.first + 1
	return value
end

return fifo