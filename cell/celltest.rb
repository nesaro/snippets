#!/usr/bin/ruby

$A1 = $A2 = $B1 = $B2 = 1
$AS = $BS = 0

threads = []

# Célula A
threads << Thread.new  {
    start = Time.now
    while (Time.now - start) < 10
        $AS = (($A1 + $A2 + $BS) >= 3) ? 1 : 0
        puts "A1 = #{$A1} A2 = #{$A2}  AS #{$AS}"
        sleep 0.3
    end
}

# Célula B
threads << Thread.new  {
    start = Time.now
    while Time.now - start < 10
        $BS = (($B1 + $B2 + $AS) >= 2) ? 1 : 0
        puts "B1 = #{BA1} B2 = #{$B2}  BS #{$BS}"
        sleep 0.3
    end
}

threads.each { |t| t.join }
