#задача 5
#робот обходит центральный прямоугольник
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

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


