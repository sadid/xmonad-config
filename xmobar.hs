-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config

-- This is setup for dual 1920x1080 monitors, with the right monitor as primary
Config {
    font = "xft:inconsolata:size=9:antialias=true",
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = Static { xpos = 0, ypos = 0, width = 1366, height = 17 },
    lowerOnStart = True,
    commands = [
        Run Weather "OICC" ["-t","<tempC>C <skyCondition>, <rh>%","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
        Run MultiCpu ["-t","Cpu: <total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 15,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 30,
        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 100,
        Run DynNetwork ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Date "%a %b %_d %l:%M" "date" 100,
        Run ThermalZone 0 ["-t","Temp: <temp>"]60,
        Run ThermalZone 1 ["-t","<temp>"]60,  
        Run CoreTemp ["-t", "<core0>|<core1>","-L","40","-H","60","-l","lightblue","-n","gray90","-h","red"]60,
        Run CpuFreq ["-t", "(<cpu0> - <cpu1>)","-L","0","-H","2","-l","lightblue","-n","white","-h","red"]60,
        Run BatteryP ["BAT0"] ["-t","<acstatus><watts> (<left>%)",
"-L","10","-H","80","-p","3",
"--","-O","<fc=green>On</fc> - ","-i","",
"-L","-15","-H","-5",
"-l","red","-m","blue","-h","green"]400,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %thermal0%,%thermal1%,%coretemp%C %multicpu% %cpufreq%   %memory%   %swap% %dynnetwork% ||<fc=#FFFFCC>%date%</fc>|| %OICC% <%battery%>"
}
