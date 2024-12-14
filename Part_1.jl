using HorizonSideRobots


r = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)


#задача 1

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


function do_upora!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n = n + 1
    end
    return n
end

function delaem!(robot)
    for side in (Nord, Ost, Sud, West)
        p = do_upora!(robot, side)
        side = inverse(side)
        move!(robot, side, p)
    end
end



#задача 2
#робот проходит по краю поля и возвращается назад


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


#задача 3
#робот проходит по всему полю и закрашивает его

function all_pole!(robot)
    num_steps_to_Sud = do_upora_num!(robot, Sud)
    num_steps_to_West = do_upora_num!(robot, West)
    side = Ost
    while !isborder(robot, Nord)
        lenght = mark_direct!(robot, side, 0)
        move!(robot, Nord, 1)
        side = inverse(side)
        lenght = mark_direct!(robot, side, 0)
        move!(robot, Nord, 1)
        side = inverse(side)
    end
    lenght = mark_direct!(robot, side, 0)
    a = do_upora!(robot, Sud)
    a = do_upora!(robot, West)
    move!(robot, Ost, num_steps_to_West)
    move!(robot, Nord, num_steps_to_Sud)
end



function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


function mark_direct!(robot, side, s::Integer)::Int
    n = 0 + s
    putmarker!(robot)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end


function do_upora!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function do_upora_num!(robot, side)
    n = 0
    while !isborder(robot, side)
       move!(robot, side)
       n = n + 1
    end
    return n
end
