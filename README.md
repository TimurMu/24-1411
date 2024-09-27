# 24-1411
Репозиторий для МИРЭА

#задача 4
#робот делает косой крест
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function cross!(robot)
    p = 0
    for side in (Nord, Ost, Sud, West)
        p = mark_direct!(robot, side, p)
    end
    move!(robot, Ost, num_steps_to_West)
    move!(robot, Nord, num_steps_to_Sud)
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function lets_go!(robot, goto)
    i = goto
    move!()
end
