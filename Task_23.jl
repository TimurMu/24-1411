using HorizonSideRobots
robot = Robot(animate = true)


inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)


function move_symmetry!(robot, side)
    if isborder(robot, side)
        obhod_border!(robot, side)
        return nothing
    else
        move!(robot, side)
        move_symmetry!(robot, side)
        move!(robot, side)
    end
end

function obhod_border!(robot, side)

    if !isborder(robot, side)
        move!(robot, side)
        move_to_emai(()->!isborder(robot, right(side)), robot, side)
        return nothing
    end
    move!(robot, left(side))
    obhod_border!(robot, side)
    move!(robot, right(side))
end

function move_to_emai(stop_condition::Function, robot, side)
    while !stop_condition()
        move!(robot, side)
    end
end

left(side) = HorizonSide((Int(side) + 1) % 4)
right(side) = HorizonSide((Int(side) + 3) % 4)
