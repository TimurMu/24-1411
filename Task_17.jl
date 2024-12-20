using HorizonSideRobots
robot = Robot(animate = true)


function find_direct!(stop_condition::Function, robot, side, nmax_steps)
    n=0
    while !(stop_condition() || (n == nmax_steps))
        move!(robot, side)
        n+=1
    end
    return stop_condition()
end

function find!(robot)
    spiral!(()->ismarker(robot), robot)
end

function spiral!(stop_condition::Function, robot)
    nmax_steps = 1
    s = Nord
    while !find_direct!(stop_condition, robot, s, nmax_steps)
        (s in (Nord, Sud)) && (nmax_steps += 1)
        s = left(s)
    end
end


left(side) = HorizonSide((Int(side)+1)%4)