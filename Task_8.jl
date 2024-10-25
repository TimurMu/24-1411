#задача 8
#робот  
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+1)%4)


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


function marshrut_blin!(robot, side) #делает маршрут
    
    i = 1.0
    while !ismarker(robot)
        move!(robot, side, Int(floor(i)))
        i += 0.5
        side = inverse(side)
    end
    
end


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end