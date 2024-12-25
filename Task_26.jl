using HorizonSideRobots

robot = Robot(animate=true)

function labirint!(robot)
    ismarker(robot) && return nothing
    putmarker!(robot)
    for s in (Nord, West, Sud, Ost)
        if !isborder(robot, s)
            move!(robot, s)
            labirint!(robot)
            move!(robot, inverse(s))
        end
    end
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)