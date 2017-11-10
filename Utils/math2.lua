local math2 = {}

-- Declare math libraries
math2.sqrt = math.sqrt
math2.rand = math.random
math2.round = math.round
math2.cos = math.cos
math2.sin = math.sin
math2.rad = math.rad
math2.deg = math.deg
math2.atan = math.atan
math2.atan2 = math.atan2
math2.max = math.max
math2.min = math.min
math2.floor = math.floor
math2.ceil = math.ceil
math2.pi = math.pi
math2.pi2 = math2.pi * 2
math2.abs = math.abs


-- Get distance between 2 objects
math2.getDistance = function ( obj1, obj2 )
    local factor = {
        x = obj2.x - obj1.x,
        y = obj2.y - obj1.y
    }
    return math2.mSqrt((factor.x * factor.x) + (factor.y * factor.y))
end

math2.getYDistance = function ( y1, y2 )
    local factor = {
        y = y2 - y1
    }
    return math2.mSqrt(factor.y * factor.y)
end

--Check for non-physics intersections

function math2.checkIntersection(obj1, obj2)
    if obj1 == nil then
    	print( "Obj1 = nil" )
        return false
    end
    if obj2 == nil then
    	print( "Obj2 = nil" )
        return false
    end
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax 
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax 
    return (left or right) and (up or down) 
end 

function math2.checkIntersectionCircle( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
    	print( "Obj1 = nil" )
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
    	print( "Obj2 = nil" )
        return false
    end

    local dx = obj1.x - obj2.x
    local dy = obj1.y - obj2.y

    local distance = U.mSqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)

    if ( distance < objectSize ) then
        return true
    end

    return false
end

function math2.calculatePercentage( value, max )
    return ( value / max ) * 100
end

function math2.lengthBetweenPoints( p1,p2 )
    return math2.abs( math2.sqrt((p2.x-p1.x)*(p2.x-p1.x) + (p2.y-p1.y)*(p2.y-p1.y)) )
end

--- Gets a heading vector for an angle.
function math2.vectorFromAngle( angle )
    return { x = math2.cos( math2.rad( angle - 90 ) ), y = math2.sin( math2.rad( angle - 90 ) ) }
end

--- Gets the angle between two position vectors.
-- vector1 The first position.
-- vector2 The second position.
function math2.angleBetweenVectors( vector1, vector2 )
    return math2.deg( math2.atan2( vector2.y - vector1.y, vector2.x - vector1.x ) ) - 90
end

--- Limits a rotation to a max rate.
-- @param current The current rotation.
-- @param target The target rotation.
-- @param maxRate The maximum number of degrees the rotation can go to.
-- @return The newly limited angle.
function math2.limitRotation( current, target, maxRate )

    if current and target and maxRate then

        local angle = target

        local d = current - angle

        --Look for alternative 
        --d = self:normaliseAngle( d )

        if d > maxRate then
            angle = current - maxRate
        elseif d < -maxRate then
            angle = current + maxRate
        end

        return angle

    end

end


return math2