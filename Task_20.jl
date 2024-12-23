using HorizonSideRobots
robot = Robot(animate = true)


function do_upora!(robot, side)
    if isborder(robot, side) 
        putmarker!(robot)
        return nothing
    end
    move!(robot, side)
    do_upora!(robot, side)
    move!(robot, HorizonSide((Int(side)+2)%4))
end