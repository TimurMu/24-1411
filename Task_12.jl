#12


using HorizonSideRobots
r = Robot(animate=true)

mutable struct CheckRobot
    robot::Robot
    f::Bool
    f_ch::Bool
end

cr=CheckRobot(r,false,false)

function count_dck!(robot)
    num_steps_West = do_predela!(robot.robot, West)
    num_steps_Sud = do_predela!(robot.robot, Sud)
    n = podschet!(robot)
    do_predela!(robot.robot, West)
    do_predela!(robot.robot, Sud)
    move!(robot.robot, Nord, num_steps_Sud)
    move!(robot.robot, Ost, num_steps_West)
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function do_predela!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function podschet!(robot)
    s = Ost
    n = 0
    while true
        n += p_line(robot, s)
        s = inverse!(s)
        isborder(robot.robot, Nord) && return n-1
        move!(robot.robot, Nord)
    end
end

function inverse!(side::HorizonSide)
    return HorizonSide((Int(side) + 2)%4)
end

function p_line(robot, side)
    n = 0
    robot.f_ch = false
    while true
        move!(robot.robot, side)
        if isborder(robot.robot, Nord)
            !robot.f && (n+=1)
            robot.f = true
            robot.f_ch = true
        else
            #!robot.f_ch && (robot.f=false)
            if !robot.f_ch
                robot.f = false
            end
            robot.f_ch = false
        end
        isborder(robot.robot, side) && return n
    end
end