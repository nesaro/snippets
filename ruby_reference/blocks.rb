#http://en.wikipedia.org/wiki/Ruby_programming_language
def remember(&p)
  @block = p
end
# Invoke the method, giving it a block that takes a name.
remember {|name| puts "Hello, " + name + "!"}

  # When the time is right -- call the closure!
@block.call("John")
