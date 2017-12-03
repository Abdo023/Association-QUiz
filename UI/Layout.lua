local l = {}

function l.horizontalLayout( width,offset )
	local group = display.newGroup( )
	group.anchorChildren = true -- In order to move children with the group
	group.children = {}

	function group.sort(  )
		local newOffset = 0
		for i=1, #group.children do
			local child = group.children[i]
			-- Check if the user provided offset or not
			if offset == nil then
				child.width = width/#group.children
				child.x = group.newX - child.width * -i	
			else
				child.x = newOffset
		
				newOffset = newOffset + child.width + offset				
			end
		end
	end

	function group.add( obj )
		group:insert( obj )	
		group.children[#group.children+1] = obj
		group.sort()
	end

	function group.remove( obj )
		-- Flag the object that needs to be removed
		obj.remove = true

		-- Itereate over the table backwards
		for i=#group.children, 1, -1 do
			if group.children[i].remove then
				-- Remove from table then from display
				table.remove( group.children, i )
				display.remove( obj )
			end
		end
		
		group.sort()
	end

	function group.clear(  )
		for i=1,#group.children do
			group.children[i]:removeSelf()
			group.children[i] = nil
		end
		group.children = {}
	end

	return group
end

return l