// clang-format off

// modify this file to change what commands output to your statusbar, and recompile using the make command.

static const Block blocks[] = {
  /* icon       command       update interval       update signal */
//   {" 󰍛 "  , "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",        30,    0 },
//    {"  "  , "df -h / | awk 'NR==2 {print $3}'",        30,    0 },
  {  " 󰸗 "    , "date '+%A %b %d %I:%M %p'"                                      ,    1 ,   0 },

{"", "sensors | awk '/^Package id 0:/ {gsub(/\\+/,\"\",$4); printf \"%d°C\\n\", $4}'", 10, 0 },


 {  ""   , "wpctl get-volume @DEFAULT_AUDIO_SINK@"                        ,    1 ,   0 },  // Update every 5 seconds

  // uncomment if you have a laptop
   {  " "   , "echo \"$(cat /sys/class/power_supply/BAT1/capacity)% \" &"  ,    20,   0 }
};

// sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
