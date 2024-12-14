using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


#задача 4
#робот делает косой крест

function xcross!(robot)
    for s = ((Nord, Ost), (Sud, Ost), (Sud, West), (Nord, West))
        n = xmark_direct!(robot, s)
        xmove!(robot, inverse.(s), n)
    end
end

function xmove!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side[1])
        move!(robot, side[2])
    end
end

function xmark_direct!(robot, side::NTuple{2, HorizonSide})
    n = 0
    while !(isborder(robot, side[1]) || isborder(robot, side[2]))
        #перегородки нет с обоих направлений
        move!(robot, side[1])
        move!(robot, side[2])
        n = n + 1
        putmarker!(robot)
    end
    return n
end


#задача 5
#робот обходит центральный прямоугольник


function opheilalalei!(robot) #финальная функция 
    while !isborder(robot, Sud) && !isborder(robot, West)
        do_upora_shagay_bistro!(robot, Sud)
        do_upora_shagay_bistro!(robot, West)
    end

    for side in [(Ost, Nord), (Sud, Ost)]
        slim_shady_gooo!(robot, side)
    end

end

function do_upora_shagay_bistro!(robot, side) #доход до стенки без отметок
    while !isborder(robot, side)
        move!(robot, side)
    end
end


function do_upora_emaie!(robot, side) #доход до стенки с отметками
    while !isborder(robot, side)
        for n = (Nord, Ost, West, Sud)
            if isborder(robot, n)
                putmarker!(robot)
            end
        end
        move!(robot, side)
    end
end


function slim_shady_gooo!(robot, side::NTuple{2, HorizonSide})
    while !isborder(robot, side[2])
        slice = side[1]
        do_upora_emaie!(robot, slice)
        putmarker!(robot)
        move!(robot, side[2])
        slice = inverse(slice)
        do_upora_emaie!(robot, slice)
    end
end




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
