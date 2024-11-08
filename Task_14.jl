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
    if robot.flag
        putmarker!(robot.robot)
    end
    if !isborder(robot.robot, side)
        move!(robot.robot, side)
        robot.flag = !robot.flag
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

function Chess!(robot)
    l = gotoangle!(robot)
    snake!(s->isborder(robot.robot, s)&&isborder(robot.robot, Nord), robot, (Ost, Nord))
    movetoend!(robot, West)
    movetoend!(robot, Sud)
    goback!(robot, l)
end

function gotoangle!(robot)
    l = []
    while !(isborder(robot.robot,Sud)&&isborder(robot.robot,West))
        !isborder(robot.robot,Sud)&&push!(l, Sud)
        !isborder(robot.robot,Sud)&&move!(robot, Sud)
        !isborder(robot.robot,West)&&push!(l, West)
        !isborder(robot.robot,West)&&move!(robot, West)
    end
    return l
end

function goback!(robot, l)
    for i in reverse(inverse.(l))
        move!(robot.robot, i)
    end
end