--- tokens: 15
-- tbox api

-- "|" speaker, must go first!
-- "@" id,      must go in between!
-- "%" option   must go in between!
-- ":" line,    must go last!

-- example usage:
-- tbox("speaker:line:line%option1%option2@id:line|newspeaker:line...")

-- listen to 'g_tbox_active', to listen if tbox is active.
-- example usage:
-- if not g_tbox_active then do_some_func() end

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len, g_tbox_select = {}, 0, 28, 1
-- g_tbox_options_open, g_tbox_active = nil, nil
