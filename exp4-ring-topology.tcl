set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
for {set i 0} {$i < 100} {incr i} {

set n($i) [$ns node]


}
puts $i
for {set i 0} {$i < 99} {incr i} {

$ns duplex-link $n($i) $n([ expr $i+1]) 1Mb 10ms DropTail


}

#$ns duplex-link $n99 $n0 1Mb 10ms DropTail

proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}
$ns at 5.0 "finish"
$ns run
