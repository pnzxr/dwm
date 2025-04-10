// clang-format off
static const Block blocks[] = {
  /* icon       command       update interval       update signal */

 // Date: 10/04 (THU)
  { "", "date '+%d/%m (%a)' | awk '{print toupper($0)}'", 1, 0 },

  // Temperature
  { "", "sensors | awk '/^Package id 0:/ {gsub(/\\+/,\"\",$4); printf \"%d°C\\n\", $4}'", 10, 0 },

  // Volume with icon
  { "", "wpctl get-volume @DEFAULT_AUDIO_SINK@", 1, 0 },

  // Battery
  { " " , "echo \"$(cat /sys/class/power_supply/BAT1/capacity)% \" &", 20, 0 },
};

// sets delimiter between status commands. NULL character ('\\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;

