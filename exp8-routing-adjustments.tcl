set ns [new Simulator]
set nf [open out.nam w]

$ns namtrace-all $nf
set nt [open test.tr w]
$ns trace-all $nt 
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n5 1Mb 10ms DropTail
$ns duplex-link $n2 $n4 1Mb 10ms DropTail
$ns duplex-link $n3 $n5 1Mb 10ms DropTail
$ns duplex-link $n4 $n0 1Mb 10ms DropTail
$ns duplex-link $n3 $n0 1Mb 10ms DropTail
$ns duplex-link $n5 $n6 1Mb 10ms DropTail
$ns duplex-link $n3 $n6 1Mb 10ms DropTail
set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp0
$ns attach-agent $n2 $udp1
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetsize_ 5000
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n0 $null0
$ns connect $udp0 $null0 
$ns at 0.0 "$cbr0 start"
$ns at 4.8 "$cbr0 stop"
$ns rtproto DV 
$ns rtmodel-at 1.5 down $n5 $n3
$ns rtmodel-at 3.0 up $n5 $n3

proc finish {} {
global ns nf nt
$ns flush-trace
close $nf
close $nt

exec nam out.nam & 
exit 0
}
$ns at 5.0 "finish" 
$ns run
