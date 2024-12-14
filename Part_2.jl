using HorizonSideRobots
robot = Robot(animate = true)

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)


#задача 8

function chetaem_shagi!(robot, side, p)  #до стенки если p == 1 то будет маркировать и возвращает кол-во шагов
    s = 0
    while !isborder(robot, side) 
        move!(robot, side)
        if p == 1
            putmarker!(robot)
        end
        s = s + 1
    end
    return s
end


function marshrut_blin!(robot, side) #делает маршрут
    
    i = 1.0
    while !ismarker(robot)
        move!(robot, side, Int(floor(i)))
        i += 0.5
        side = inverse(side)
    end
    
end


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end



# Задача 9


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
        robot.flag = false    
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
        do_upora_emai!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end

    do_upora_emai!(robot, side)
    do_upora_emai!(robot, Sud)
    do_upora_emai!(robot, West)
    
    for i in 1:x
        move!(robot, Ost) 
    end

    for j in 1:y
        move!(robot, Nord) 
    end
end



# Задача 10

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
        robot.flag = false    
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
        do_upora_emai!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end

    do_upora_emai!(robot, side)
    do_upora_emai!(robot, Sud)
    do_upora_emai!(robot, West)
    
    for i in 1:x
        move!(robot, Ost) 
    end

    for j in 1:y
        move!(robot, Nord) 
    end
end
