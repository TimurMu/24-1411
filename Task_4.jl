#задача 4
#робот делает косой крест
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

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
