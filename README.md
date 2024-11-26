using HorizonSideRobots
robot = Robot(animate = true)

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

s = 0
mutable struct R
    robot::Robot
    flag::Bool
end

RR = R(robot, false)

function HorizonSideRobots.move!(robot::R, side)
    
    if robot.flag
        putmarker!(robot.robot)
    end

    move!(robot.robot, side)

end


function do_upora_emai!(robot, side)
    while !isborder(robot.robot, side)    
        move!(robot, side)
    end
end

function chetaem_ne_stenki_gadem!(robot, side)
    global s
    previos_values = false

    while !isborder(robot.robot, side) 
        if !isborder(robot.robot, Nord)
            



        if previos_values != robot.flag
            s += 1
        end
        move!(robot, side)
    end
    println(s)
end


function snake_mini_kapetz!(robot)


    

    while !isborder(robot.robot, Nord)
        do_upora_emai!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end

    #Написать запоминание маргрута и возваращение по нему в исходную позицию
end
