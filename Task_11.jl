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
    n = 0
    while !isborder(robot.robot, side)    
        move!(robot, side)
        n += 1
    end
    return n 
end


function chetaem_ne_stenki_gadem!(robot, side) # После функции добавить проверку на одинаковость флагов
    global s
    previos_values = false

    while !isborder(robot.robot, side) 
        if !isborder(robot.robot, Nord)
            robot.flag = false
        else
            robot.flag = true
        end

        if previos_values != robot.flag
            s += 1
        end

        move!(robot, side)
        previos_values = robot.flag
    end
    robot.flag = false
    if previos_values != robot.flag
        s += 1
    end
    previos_values = false
end


function snake_mini_kapetz!(robot)
    global s
    side = Ost
    go = a_marchrut_k_ugly!(robot)

    while !isborder(robot.robot, Nord)
        chetaem_ne_stenki_gadem!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end
    do_upora_emai!(robot, West)
    do_upora_emai!(robot, Sud)
    b_marchrut_ot_ugla!(robot, go)
    s //= 2
    println(Int(floor(s)))
    #Написать запоминание маргрута и возваращение по нему в исходную позицию
end



function a_marchrut_k_ugly!(robot)
    navigation = []
    while !isborder(robot.robot, West) && !isborder(robot.robot, Sud)
        if !isborder(robot.robot, West)
            num_ = do_upora_emai!(robot,West)  
            push!(navigation, (num_, West))
        end
        if !isborder(robot.robot, Sud)
            num_ = do_upora_emai!(robot, Sud)  
            push!(navigation, (num_, Sud))  
        end  
    end 
    return navigation
end

function b_marchrut_ot_ugla!(robot, navigation)

    for i in reverse(navigation)
        for _ in 1:i[1]
            move!(robot.robot, inverse(i[2]))
        end
    end
end