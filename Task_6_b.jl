#задача 6 b
#робот обходит все препятствия и ставит маркеры у внешнего барьера 
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


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