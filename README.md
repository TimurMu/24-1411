# 24-1411
Репозиторий для МИРЭА

#задача 6
#робот обхрдит все препятствия и ставит маркеры у внешнего барьера 
using HorizonSideRobots



r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


function square!(robot)
    for s in (Ost, Sud, West, Nord)
        do_stenki_bistro!(robot, s, 1)    
    end
end

function do_stenki_bistro!(robot, side, p)
    while !isborder(robot, side)
        if p == 1
            putmarker!(robot)
        end
        move!(robot, side)
    end
end

function chetaem_shagi!(robot, side)
    s = 0
    while !isborder(robot, side) 
        move!(robot, side)
        putmarker!(robot)
        s = s + 1
    end
    return s
end
