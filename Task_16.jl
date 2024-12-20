using HorizonSideRobots


robot = Robot(animate = true)
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function start!(robot)
    shuttle!((s)->!isborder(robot, Nord), robot, Ost)
end

function shuttle!(stop_condition::Function, robot, start_side) 
    s = start_side 
    n = 0 
    while !stop_condition(s) 
        move!(robot, s, n) 
        s = inverse(s) 
        n += 1 
    end
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end