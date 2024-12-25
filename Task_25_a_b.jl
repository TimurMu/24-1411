using HorizonSideRobots


robot = Robot(animate=true)

function markchess_1!(robot, side)
    putmarker!(robot)
    isborder(robot, side) && return
    move!(robot, side)
    markchess_0!(robot, side)
    end

function markchess_0!(robot, side)
    isborder(robot, side) && return
    move!(robot, side)
    markchess_1!(robot, side)
end
