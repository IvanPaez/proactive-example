set term png size 800, 600
set output 'current.png'
set xlabel "Time (sec)"
set ylabel "Current (mA)"
set style line 1 lt 1 lw 1 lc 1
plot '~/Desktop/iot-lab/7381/current.csv' using 2:($3*1000) with lines title "" linestyle 1
