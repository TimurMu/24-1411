using HorizonSideRobots
robot = Robot(animate = true)


function do_upora!(robot, side)
    isborder(robot, side) && return nothing
    move!(robot, side)
    do_upora!(robot, side)
end