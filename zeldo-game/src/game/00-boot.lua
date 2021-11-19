-- PRD_MODE_BEGIN
-- String data used throughout the cartridge.
reload(0, 0, 0x4300, "STORE_FILEPATH")

g_gunvals_raw = "ZTABLE_STRINGS_FIRST"
for i=1,ZTABLE_STRINGS_SECOND_LEN do
   g_gunvals_raw = g_gunvals_raw..chr(peek(i))
end

-- DEBUG_BEGIN
printh("ZTABLE_STRINGS_FIRST")
printh("ZTABLE_STRINGS_SECOND")
printh("ZTABLE_STRINGS")
printh(g_gunvals_raw)
-- DEBUG_END

reload()
-- PRD_MODE_END

-- DEV_MODE_BEGIN
-- String data used throughout the cartridge.
g_gunvals_raw="ZTABLE_STRINGS"
-- DEV_MODE_END
