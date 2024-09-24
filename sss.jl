#задача 1
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


function do_upora!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n = n + 1
    end
    return n
end

function delaem!(robot)
    for side in (Nord, Ost, Sud, West)
        p = do_upora!(robot, side)
        side = inverse(side)
        move!(robot, side, p)
    end
end


