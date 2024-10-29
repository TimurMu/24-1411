#задача 9
#робот обходит все препятствия и ставит маркеры у внешнего барьера 
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

RR = R(robot, true)
mutable struct R
    robot::Robot
    flag::Bool
end

function do_stenki_bistro!(robot, side) #до стенки
    while !isborder(robot, side)
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
    return (s, side)
end


function marshrut_blin!(robot) #делает маршрут
    start_y = chetaem_shagi!(robot, Sud, 0)[1]
    start_x = chetaem_shagi!(robot, West, 0)[1]
    if start_x % 2 == 1
        RR.flag = false
    end
end


# function HorizonSideRobots.move!(robot, side, num_steps::Integer)
#     for _ in 1:num_steps
#         if RR.flag == true
#             putmarker!(robot)
#         end
#         move!(robot, side)
#     end
# end


function HorizonSideRobots.move!(robot, side)
    for _ in 1:num_steps
        if RR.flag == true
            putmarker!(robot)
        end
        move!(robot, side)
    end
end
