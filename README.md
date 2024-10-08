# 24-1411
Репозиторий для МИРЭА

#задача 5
#робот обходит центральный прямоугольник
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function opheilalalei!(robot)
    while !isborder(robot, Sud) && !isborder(robot, West)
        do_upora_emaie!(robot, Sud)
        do_upora_emaie!(robot, West)
    end
    for side = (Ost, Nord), (Nord, West)
        
    end
end

function do_upora_emaie!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end


function slim_shady_gooo!(robot, side::NTuple{2, HorizonSide})
    while !isborder(robot, side[2])
        do_upora_emaie(robot, side[1])

    end
end



function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function obed_programmer_check!(robot, side)
    
    
end 
