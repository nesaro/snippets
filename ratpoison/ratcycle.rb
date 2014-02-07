#!/usr/bin/ruby

RP="/home/bourbaki/bin/ratpoison"
actual=`#{RP} -c fdump`
#ventanas=`#{RP} -c windows`
while (true)
#  mandato="ratpoison -c \"frestore "+ventanas.to_s+'"'
mandato="0 0 300 800 300 14680067 23,1 0 0 400 300 23068686 395,2 400 0 400 300 20971534 25,"
   system(RP + " -c \"frestore " + mandato +"\"")
  puts mandato
  sleep(10)
  #mandato="0 0 300 800 300 14680067 23,1 0 0 400 300 23068686 30,2 400 0 400 300 18874435 28,"
mandato="0 0 300 800 300 14680067 397,1 0 0 400 300 23068686 395,2 400 0 400 300 18874435 396,"
   system(RP + " -c \"frestore " + mandato +"\"")
 # mandato="focusright"
 #  system(RP + " -c\"" + mandato +"\"")
 # mandato="next"
 #  system(RP + " -c\"" + mandato +"\"")
 # mandato="focusleft"
 #  system(RP + " -c\"" + mandato +"\"")
   sleep(10)
end
