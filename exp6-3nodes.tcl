set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
$ns duplex-link $n0 $n2 5Mb 10ms DropTail
$ns duplex-link $n1 $n2 5Mb 10ms DropTail
$ns duplex-link $n1 $n0 5Mb 10ms DropTail
set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp0
$ns attach-agent $n2 $udp1
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetsize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n0 $null0
$ns connect $udp0 $null0
$ns connect $udp1 $null0
$ns at 0.0 "$cbr0 start"
$ns at 4.9 "$cbr0 stop"
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}
$ns at 5.0 "finish"
$ns run
