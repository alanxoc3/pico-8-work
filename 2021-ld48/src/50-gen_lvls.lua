function create_block(id, xf, ...)
    return {sind=rnd_item{...}, xf=xf, id=id}
end

function draw_lvl_blocks(tbl)
    -- draw bkgd
    for y, v in pairs(tbl) do
        for x, a in pairs(v) do
            spr(a.sind, x*8, y*8, 1, 1, a.xf, a.yf)
        end
    end
end

function allocate_level(blocks, context, yloc)
    local buffer = flr(abs(context.buffer))
    local infinite = context.infinite
    local infinite_buffer = context.infinite_buffer
    yloc = flr(yloc)

    -- draw bkgd
    if infinite and yloc + infinite_buffer > context.room.h then
        context.room.h = yloc + infinite_buffer
    end

    for y, v in pairs(blocks) do
        if y < yloc - buffer then
            blocks[y] = nil
        end
    end

    for y=(yloc-buffer),(yloc+buffer) do
        if not blocks[y] then
            blocks[y] = context:generate(y)
        end
    end
end

function gen_lvl(lvl)
    local infinite, generate, height, infinite_buffer, buffer

    if lvl == 0 then
        infinite = true
        generate = gen_title_row
        height = 30
        infinite_buffer = 22
        buffer = 18
    elseif lvl > 0 and lvl < 4 then
        infinite = false
        generate = gen_well_row
        height = 14*14 + (lvl-1)*7*7
        infinite_buffer = 40
        buffer = 18
    else
        infinite = true
        generate = gen_clown_row
        height = 30
        infinite_buffer = 40
        buffer = 18
    end

    local room = tabcpy(ztable([[
        x:0; y:0; w:12; h:@1;
    ]], height))

    local context = tabcpy(ztable([[
        spike_counter_left:0;
        spike_counter_right:0;
        plat_counter_left:0;
        plat_counter_right:0;
        plat_counter_middle:0;

        lvl:@1;
        room:@2;
        buffer:@3;
        infinite:@4;
        infinite_buffer:@5;
        generate:@6;
    ]], lvl, room, buffer, infinite, infinite_buffer, generate))

    local bucket = _g.bucket_control(room.w/2, -1.5)
    local view = _g.view(15, 16, 0, bucket)

    return context, room, bucket, view
end
