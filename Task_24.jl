using HorizonSideRobots

robot = Robot(animate=true)

function go!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        return movebool!(robot, inverse(side), go!(robot, side))
    else 
        return true
    end    
end

function movebool!(robot, side, flag)
    flag || return true
    move!(robot, side)
    return false
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)