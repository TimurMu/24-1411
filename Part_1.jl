using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


#задача 1

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



#задача 2
#робот проходит по краю поля и возвращается назад


function square!(robot)
    num_steps_to_Sud = do_upora!(robot, Sud)
    num_steps_to_West = do_upora!(robot, West)
    p = 0
    for side in (Nord, Ost, Sud, West)
        p = mark_direct!(robot, side, p)
    end
    move!(robot, Ost, num_steps_to_West)
    move!(robot, Nord, num_steps_to_Sud)
end

function do_upora!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function mark_direct!(robot, side, s::Integer)::Int
    n = 0 + s
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end


#задача 3
#робот проходит по всему полю и закрашивает его

function all_pole!(robot)
    num_steps_to_Sud = do_upora_num!(robot, Sud)
    num_steps_to_West = do_upora_num!(robot, West)
    side = Ost
    while !isborder(robot, Nord)
        lenght = mark_direct!(robot, side, 0)
        move!(robot, Nord, 1)
        side = inverse(side)
        lenght = mark_direct!(robot, side, 0)
        move!(robot, Nord, 1)
        side = inverse(side)
    end
    lenght = mark_direct!(robot, side, 0)
    a = do_upora!(robot, Sud)
    a = do_upora!(robot, West)
    move!(robot, Ost, num_steps_to_West)
    move!(robot, Nord, num_steps_to_Sud)
end



function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


function mark_direct!(robot, side, s::Integer)::Int
    n = 0 + s
    putmarker!(robot)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end


function do_upora!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function do_upora_num!(robot, side)
    n = 0
    while !isborder(robot, side)
       move!(robot, side)
       n = n + 1
    end
    return n
end


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
