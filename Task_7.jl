#задача 7
#робот  
using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


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