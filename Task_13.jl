using HorizonSideRobots


robot = Robot(animate = true)

function inverse(side::NTuple{2,HorizonSide})
    s = (HorizonSide((Int(side[1])+2)%4), side[2])
    return s
end

function movetoend!(stop_condition::Function, robot, side) 
    n=0 
    while !stop_condition() 
            move!(robot, side) 
            if mod(n,2) == 0
                putmarker!(robot)
            end
            n+=1 
    end 
end

function do_upora!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)   
    end 
end

function snake!(stop_condition::Function, robot, sides::NTuple{2,HorizonSide}) 
    do_upora!(robot, West)
    do_upora!(robot, Sud)
    s=sides[1] 
    while !stop_condition() 
        movetoend!(()->stop_condition() || isborder(robot, s), robot, s) 
        if stop_condition() 
            break 
        end 
        s = inverse(s) 
        move!(robot, sides[2]) 
    end
    movetoend!(()->stop_condition() || isborder(robot, s), robot, s)
end
