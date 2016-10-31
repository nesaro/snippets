#!/usr/bin/ruby


begin
numant="%d" % 0x1cbb0000
100000.times{ |i|
    puts "Cual es el siguiente offset?"
    numhex=gets
    numtemp="0x"+numhex
    num = "%d" % numtemp
    puts num,numtemp
    orden="dd bs=1 skip=#{numant.to_s} count=#{(num.to_i-numant.to_i).to_s} if=/dev/cdrom of=salida#{numant.to_s}-#{num.to_s}.jpg"
    puts orden
    system(orden)
    numant=num

}

end
