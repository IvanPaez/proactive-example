set term png size 800,600
set output 'voltage.png'
set xlabel "Time (sec)"
set ylabel "Voltage(mV)"
set style line 1 lt 1 lw 2 lc 1
plot '~/Desktop/iot-lab/7381/voltage.csv' using 2:($3*1000) with lines title "" linestyle 1
