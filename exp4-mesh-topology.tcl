set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
for {set j 0} {$j<20} {incr j} {
set n($j) [$ns node]
}
for {set i 0} {$i<20} {incr i} {
for {set j 0} {$j<20} {incr j} {
if {$i != $j} {
$ns duplex-link $n($i) $n($j) 1Mb 10ms DropTail
}
}
}
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}
$ns at 5.0 "finish"
$ns run 
