--
--Code for a queue with size of n
--use it in your code as 'local queue = require("fixedQueue")' and call queue.new(50)
--
local queue = {}

function queue.new (size)
	queue.max = size
	queue.q={}
end

function queue.isEmpty()
	if table.getn(queue.q) == 0 then
		return true
	end
	return false
end
    
function queue.size()
	return table.getn(queue.q)
end
	
function queue.push (t)
	table.insert(queue.q,1,t)
	if #queue.q > queue.max then
		table.remove(queue.q)
	end
end

function queue.getAll()
   return queue.q
end

-- you will get a nil if it does not exists
function queue.get (i)
	return queue.q[i]
end

return queue


