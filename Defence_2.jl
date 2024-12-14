using HorizonSideRobots


robot = Robot(animate = true)


# Задача 11

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

s = 0
mutable struct R
    robot::Robot
    flag::Bool
end

RR = R(robot, false)


function HorizonSideRobots.move!(robot::R, side)
    
    if robot.flag
        putmarker!(robot.robot)
    end

    move!(robot.robot, side)

end


function do_upora_emai!(robot, side)
    n = 0
    while !isborder(robot.robot, side)    
        move!(robot, side)
        n += 1
    end
    return n 
end


function chetaem_ne_stenki_gadem!(robot, side)
    global s
    previos_values = false

    while !isborder(robot.robot, side) 
        if !isborder(robot.robot, Nord)
            robot.flag = false
        else
            robot.flag = true
        end

        if previos_values != robot.flag
            s += 1
        end

        move!(robot, side)
        previos_values = robot.flag
    end
    robot.flag = false
    if previos_values != robot.flag
        s += 1
    end
    previos_values = false
end


function snake_mini_kapetz!(robot)
    global s
    side = Ost
    go = a_marchrut_k_ugly!(robot)

    while !isborder(robot.robot, Nord)
        chetaem_ne_stenki_gadem!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end
    do_upora_emai!(robot, West)
    do_upora_emai!(robot, Sud)
    b_marchrut_ot_ugla!(robot, go)
    s //= 2
    println(Int(floor(s)))
    #Написать запоминание маргрута и возваращение по нему в исходную позицию
end



function a_marchrut_k_ugly!(robot)
    navigation = []
    while !isborder(robot.robot, West) && !isborder(robot.robot, Sud)
        if !isborder(robot.robot, West)
            num_ = do_upora_emai!(robot,West)  
            push!(navigation, (num_, West))
        end
        if !isborder(robot.robot, Sud)
            num_ = do_upora_emai!(robot, Sud)  
            push!(navigation, (num_, Sud))  
        end  
    end 
    return navigation
end

function b_marchrut_ot_ugla!(robot, navigation)

    for i in reverse(navigation)
        for _ in 1:i[1]
            move!(robot.robot, inverse(i[2]))
        end
    end
end



#12

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



# Задча 13

function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

mutable struct ChessRobot
    robot::Robot
    flag::Bool
end

function HorizonSideRobots.move!(robot::ChessRobot,side)
    (robot.flag) && (putmarker!(robot.robot))
    move!(robot.robot,side)
    robot.flag=(!robot.flag)
end

HorizonSideRobots.isborder(robot::ChessRobot,side)=isborder(robot.robot,side)

function do_upora!(robot,side)
    counter=0
    while (!isborder(robot,side))
        move!(robot,side)
        counter+=1
    end
    return counter
end

function to_start!(robot)
    x=do_upora!(robot,West)
    y=do_upora!(robot,Sud)
    return (x,y)
end

function to_dot!(robot,coord::NTuple{2,Int})
    move!(robot,Nord,coord[2])
    move!(robot,Ost,coord[1])
end

function movetoend!(stop_condition::Function,robot,side)
    counter=0
    while (!stop_condition() && !isborder(robot,side))
        move!(robot,side)
        counter+=1
    end
    return counter
end

function snake!(stop_condition::Function,robot,sides::NTuple{2,HorizonSide})
    s=sides[1]
    while (!(stop_condition()) && !isborder(robot,sides[2]))
        movetoend!(()->stop_condition(),robot,s)
        if stop_condition()
            break
        end
        s=inverse(s)
        move!(robot,sides[2])
    end
    movetoend!(()->stop_condition(),robot,s)
end

function main(robot)
   r=ChessRobot(robot,true)
    path=to_start!(r)
    snake!(()->isborder(robot,Nord)&&(isborder(robot,Ost)),r,(Ost,Nord))
    to_start!(r)
    to_dot!(r,path)
end



# Задача 14


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
