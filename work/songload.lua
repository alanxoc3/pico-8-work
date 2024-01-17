-- some constants in measurements of seconds
MAX_SONG_TOTAL_LENGTH  = 60*7
MAX_SONG_REPEAT_LENGTH = 10
MAX_SONG_RAND_REPEAT_LENGTH = 5
FADE_OUT_LENGTH = 1.25
PAUSE_LENGTH = 1
FADE_IN_LENGTH = 0

function start_recording()
  g_filename = "track_"..g_tracknum
  extcmd("set_filename", g_filename)
  extcmd("audio_rec")
  printh("started recording!")
end

function end_recording()
  extcmd("audio_end", 1)
  printh("--------------------------")
  printh("finished recording!")
end

function _init()
  if stat(6) ~= "" then
    memset(0x3100, 0, 0x1200)
    reload(0x3100, 0x3100, 0x1200, stat(6))
  end

  g_playlist = {}
  g_viewed_tracks = {}
  for i=0,63 do
    if not g_viewed_tracks[i] then
      local sl, sr, st = calc_song_len(i)
      if sl > 0 then
        add(g_playlist, i)
      end
      g_viewed_tracks[i] = true
      for t, _ in pairs(st) do
        g_viewed_tracks[t] = true
      end
    end
  end

  g_total_count = #g_playlist
  load_song()
end

function load_song()
  if #g_playlist > 0 then
    if #g_playlist < g_total_count then
      end_recording()
    end
    g_tracknum = deli(g_playlist, 1)
    start_recording()
  else
    end_recording()
    printh("songs saved to current folder. you may close pico8 now.")
    stop("songs saved to current folder")
  end

  -- reload current cart first because it has a stop at every track, ensuring bad files won't be played
  local song_len, does_repeat = calc_song_len(g_tracknum)
  song_len = min(song_len, MAX_SONG_TOTAL_LENGTH)
  g_song_len = song_len+(does_repeat and (MAX_SONG_REPEAT_LENGTH) or 0)

  g_pause_song_count = 0
  g_remaining_song_time = g_song_len
end

-- uncomment for debugging. not needed in production though.
function _draw()
  cls()

  local minutes = ((g_remaining_song_time or 0)+.5)\1\60
  local seconds = ((g_remaining_song_time or 0)+.5)\1%60
  cursor(1, 1)
  color(7)
  print("started recording!")
  color(6)
  print("total status: "..(g_total_count-#g_playlist).."/"..g_total_count)
  print("track num: "..g_tracknum)
  print("track timer: "..minutes.."m "..seconds.."s")

  g_track_str = ""
  for ind in all(g_playlist) do
    g_track_str ..= " "..ind
  end

  print("tracks left:"..g_track_str)
end

function _update60()
  local cur_track, cur_tick, is_music_playing = stat(54), stat(56), stat(57)

  -- pause before we actually start playing the music
  if g_pause_song_count then
    if g_pause_song_count >= 60*PAUSE_LENGTH then
      g_pause_song_count = nil
      music(g_tracknum, 1000*FADE_IN_LENGTH)
    end

  -- give some time to fade out before loading the next song
  elseif g_next_song_count then
    if g_next_song_count >= 60*FADE_OUT_LENGTH then
      g_next_song_count = nil
      load_song()
    end

  -- if time is over or music is not playing, then start next song count
  elseif btnp(4) or btnp(5) or g_remaining_song_time <= 0 or not is_music_playing then
    music(-1, 1000*FADE_OUT_LENGTH)
    g_next_song_count = 0

  elseif g_remaining_song_time then
    g_remaining_song_time = max(0, g_remaining_song_time-1/60)
  end

  -- update timers
  if g_pause_song_count    then g_pause_song_count += 1 end
  if g_next_song_count     then  g_next_song_count += 1 end

  if t()%1 == 0 then
    local minutes = ((g_remaining_song_time or 0)+.5)\1\60
    local seconds = ((g_remaining_song_time or 0)+.5)\1%60
    printh("--------------------------")
    printh("total status: "..(g_total_count-#g_playlist).."/"..g_total_count)
    printh("track num: "..g_tracknum)
    printh("track timer: "..minutes.."m "..seconds.."s")

    g_track_str = ""
    for ind in all(g_playlist) do
      g_track_str ..= " "..ind
    end

    printh("tracks left:"..g_track_str)
  end
end

-- return song_len_in_seconds, does_song_repeat, used_tracks
function calc_song_len(track)
  local cur_track = track
  local tracks = {}
  local does_repeat = true

  -- or cur_track is empty (stop)
  while not tracks[cur_track] do
    local trackdata  = peek4(0x3100+cur_track*4)
    local data_stop  = trackdata & 0x0080.0000 ~= 0
    local data_end   = trackdata & 0x0000.8000 ~= 0
    local data_beg   = trackdata & 0x0000.0080 ~= 0

    local track_len, chan_count = calc_track_len(trackdata)
    if chan_count == 0 then
      does_repeat = false
      break
    end

    tracks[cur_track] = track_len

    if data_stop then
      cur_track = cur_track
      does_repeat = false
    elseif data_end then
      while cur_track > 0 do
        if (peek4(0x3100+cur_track*4) & 0x0000.0080) ~= 0 then
          break
        end
        cur_track -= 1
      end
    else
      cur_track = max(0, min(63, cur_track+1))
    end
  end

  local song_len = 0
  for k,v in pairs(tracks) do
    song_len += v
  end

  return max(0, song_len), does_repeat, tracks
end

-- return track_len_in_seconds, channel_count
function calc_track_len(trackdata)
  local channels = {}
  if trackdata & 0x0000.0040 == 0 then add(channels,  shl(trackdata & 0x0000.003f, 16)) end
  if trackdata & 0x0000.4000 == 0 then add(channels,  shl(trackdata & 0x0000.3f00,  8)) end
  if trackdata & 0x0040.0000 == 0 then add(channels, lshr(trackdata & 0x003f.0000,  0)) end
  if trackdata & 0x4000.0000 == 0 then add(channels, lshr(trackdata & 0x3f00.0000,  8)) end

  local slowest = 0
  for sfxid in all(channels) do
    local sfx_speed, does_loop = calc_sfx_len(sfxid)
    if not does_loop then
      return sfx_speed, #channels
    elseif sfx_speed > slowest then
      slowest = sfx_speed
    end
  end

  return slowest, #channels
end

-- return len_in_seconds, does_it_loop
function calc_sfx_len(sfxid)
  local sfxaddr    = 0x3200 + sfxid*68
  local speed      = max(1, @(sfxaddr+65))
  local loop_start = @(sfxaddr+66)
  local loop_end   = @(sfxaddr+67)
  local sfxlen     = 32
  if loop_end == 0 and loop_start > 0 then sfxlen = loop_start end
  return speed / 120 * sfxlen, loop_end > loop_start
end
