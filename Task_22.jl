using HorizonSideRobots
robot = Robot(animate = true)


inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function go!(robot, side, count)
    if !isborder(robot, side)
        move!(robot, side)
        n = go!(robot, side, count + 1)
    else
        move!(robot, inverse(side), count)
        n = move!(robot, inverse(side), count)
    end
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps)
    for i in 1:num_steps
        if isborder(robot, side)
            move!(robot, inverse(side), i - 1)
            return false
        else
            move!(robot, side)
        end
    end
    return true
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)