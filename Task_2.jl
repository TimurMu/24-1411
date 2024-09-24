#задача 2
#робот проходит по краю поля и возвращается назад
using HorizonSideRobots


r = Robot(animate=true)
function square!(robot)
    num_steps_to_Sud = do_upora!(robot, Sud)
    num_steps_to_West = do_upora!(robot, West)
    p = 0
    for side in (Nord, Ost, Sud, West)
        p = mark_direct!(robot, side, p)
    end
    move!(robot, Ost, num_steps_to_West)
    move!(robot, Nord, num_steps_to_Sud)
end

function do_upora!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function mark_direct!(robot, side, s::Integer)::Int
    n = 0 + s
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end



# function mark_direct!(robot, side, s::Integer)::Int
#     n = 0 + s
#     while !isborder(robot, side)
#         move!(robot, side)
#         if (((n)%2) == 0)
#             putmarker!(robot)
#         end
#         n += 1
#     end
#     return n
# end