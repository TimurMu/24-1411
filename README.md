using HorizonSideRobots

robot = Robot(animate=true)


mutable struct R
    robot::Robot
    flag::Bool
end

RR = R(robot, true)

function move_border!(robot, side)
    if !isborder(robot.robot, side)
        move!(robot, side)
        movetocondition!(()->!isborder(robot.robot, left(side)), robot, side)
        return false
    end
    if isborder(robot.robot, right(side))
        return true
    end
    move!(robot, right(side))
    k = move_border!(robot, side)
    move!(robot, left(side))
    return k
end

function left(side::HorizonSide)
    return HorizonSide((Int(side)+1)%4)
end

function right(side::HorizonSide)
    return HorizonSide((Int(side)+3)%4)
end

function movetocondition!(stop_condition::Function, robot, side)
    while !stop_condition()
        move!(robot, side)
    end
end

function HorizonSideRobots.move!(robot::R, side)
    if !isborder(robot.robot, side)
        move!(robot.robot, side)
        robot.flag = !robot.flag
    end
    if robot.flag
        putmarker!(robot.robot)
    end
end

function snake!(stop_condition::Function, robot, sides::NTuple{2, HorizonSide})
    s = sides[1]
    while !stop_condition(s)
        movetoend!(robot, s)
        if stop_condition(s)
            break
        end
        s = inverse(s)
        move!(robot, sides[2])
    end
end

function inverse(side::HorizonSide)
    return HorizonSide((Int(side) + 2)%4)
end

function movetoend!(robot, side)
    n = 0
    if robot.flag
        putmarker!(robot.robot)
    end
    while true
        if isborder(robot.robot, side)
            if move_border!(robot, side)
                return nothing
            end
        else
            move!(robot, side)
        end
    end
    return n
end




using HorizonSideRobots
robot = Robot(animate = true)

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)


mutable struct R
    robot::Robot
    flag::Bool
end

RR = R(robot, true)

function HorizonSideRobots.move!(robot::R, side)
    
    if robot.flag
        putmarker!(robot.robot)
    end

    if !isborder(robot.robot, side)
        move!(robot.robot, side)
        robot.flag = !robot.flag
    end

end


function do_upora_emai!(robot, side)
    while !isborder(robot.robot, side)    
        move!(robot, side)
    end
end

function chetaem_shagi!(robot, side)
    n = 0
    while !isborder(robot.robot, side)    
        move!(robot, side)
        n += 1
    end

    return n
end


function snake_mini_kapetz!(robot)
    y = chetaem_shagi!(robot, Sud)
    x = chetaem_shagi!(robot, West)
    side = Ost

    if x % 2 == 0
        robot.flag = !robot.flag
    end

    while !isborder(robot.robot, Nord)
        do_upora_emai!(robot.robot, side)
        move!(robot.robot, Nord)
        side = inverse(side)
    end
    
end

function no_stene!(robot, side)
    function HorizonSideRobots.move!(robot::R, side)
        for _ in 1:num_steps
            move!(robot, side)
        end
    end
end
