#задача 6 a
#робот обхрдит все препятствия и ставит маркеры у внешнего барьера 
using HorizonSideRobots



r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


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