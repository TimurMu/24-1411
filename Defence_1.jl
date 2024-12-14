using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

#задача 6 a
#робот обхрдит все препятствия и ставит маркеры у внешнего барьера 



function square!(robot) #проход по квадрату
    for s in (Ost, Sud, West, Nord)
        do_stenki_bistro!(robot, s, 1)
    end

end

function do_stenki_bistro!(robot, side, p) #до стенки если p == 1 то будет маркировать
    while !isborder(robot, side)
        if p == 1
            putmarker!(robot)
        end
        move!(robot, side)
    end
end

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


function marshrut_blin!(robot) #делает маршрут
    ar = []
    while !isborder(robot, West) || !isborder(robot, Nord)
        push!(ar, chetaem_shagi!(robot, West, 0))
        push!(ar, chetaem_shagi!(robot, Nord, 0))
    end 
    p = 0
    for i in 1:length(ar)
        side = [Sud, Ost]
        move!(robot, side[p%2+1], ar[length(ar)-i+1])
        p += 1
    end
end


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


#задача 6 b
#робот обходит все препятствия и ставит маркеры у внешнего барьера 

function square!(robot, x, y) #проход по квадрату
    for s in (Ost, Sud, West, Nord)
        do_stenki_bistro_s_podvofom!(robot, s, x, y)
        
    end
end

function do_stenki_bistro_s_podvofom!(robot, side, x, y) #до стенки
    i = 0
    while !isborder(robot, side)
        move!(robot, side)
        i += 1
        if side == Ost && i == x
            putmarker!(robot)
        end
        if side == Sud && i == y
            putmarker!(robot)
        end
        if side == West && i == 11 - x
            putmarker!(robot)
        end
        if side == Nord && i == 10 - y
            putmarker!(robot)
        end
    end
end

function chetaem_shagi!(robot, side, p)  #до стенки если p == 1 то будет маркировать и возвращает кол-во шагов
    s = 0
    while !isborder(robot, side) 
        move!(robot, side)
        if p == 1
            putmarker!(robot)
        end
        s = s + 1
    end
    return (s, side)
end


function marshrut_blin!(robot) #делает маршрут
    ar = []
    while !isborder(robot, West) || !isborder(robot, Nord)
        push!(ar, chetaem_shagi!(robot, West, 0)[1])
        push!(ar, chetaem_shagi!(robot, Nord, 0)[1])
    end 
    x = 0
    y = 0
    for i in 1:length(ar)
        if i % 2 == 1
            x += ar[i]
        end
        if i % 2 == 0
            y += ar[i]
        end
    end
    square!(robot, x, y)
    p = 0
    for i in 1:length(ar)
        side = [Sud, Ost]
        move!(robot, side[p%2+1], ar[length(ar)-i+1])
        p += 1
    end
end


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


#задача 7

function marshrut_blin!(robot, side) #делает маршрут
    i = 1
    while isborder(robot, Nord)
        move!(robot, side, i)
        side = inverse(side)
        i += 1
    end
    
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


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


# Задание 9

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


# Задание 10

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
