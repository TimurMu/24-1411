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

function do_upora!(robot, side)
    while !isborder(robot.robot, side)
        move!(robot.robot, side)   
    end 
end

function chetaem_ne_stenki_gadem!(robot, side)
    countwall = 0 
    current = 0
    isWall = false
    while !isborder(robot.robot, side)
        if !isborder(robot.robot, Nord)
            current += 1
            if current > 1 && isWall
                countwall += 1
                isWall = false
            end
        else
            isWall = true
            current = 0
        end
        move!(robot.robot, side)
    end
    if isWall == true
        countwall += 1
    end
    return countwall
end


function snake_mini_kapetz!(robot)
    total_count = 0
    do_upora!(robot, West)
    do_upora!(robot, Sud)
    side = Ost
    while !isborder(robot.robot, Nord)
        total_count += chetaem_ne_stenki_gadem!(robot, side)
        move!(robot.robot, Nord)
        side = inverse(side)
    end
    return total_count
end
