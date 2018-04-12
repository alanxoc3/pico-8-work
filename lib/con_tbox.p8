-- tbox api
-- speaker:line:line%option1%option2@id:line|newspeaker:line...
-- speaker must go first! line must go last! options and id are in between!

-- "|" speaker
-- "@" id
-- "%" option
-- ":" line

tbox_messages={} -- the array for keeping track of text box overflows
g_tbox_anim=0
g_tbox_max_len=28
g_tbox_options_open=false
g_tbox_select=0
