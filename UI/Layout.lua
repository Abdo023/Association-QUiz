local l = {}

function l.horizontalLayout( width,offset )
	local group = display.newGroup( )
	group.anchorChildren = true -- In order to move children with the group
	local rect = display.newRect( group, 0, 0, 0, 40 )
	group.rect = rect
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

	function group.setPos( x,y )
		group.newX = x
		group.newY = y
		group.rect.x = x
		group.rect.y = y
		group.sort()
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

	return group
end

return l