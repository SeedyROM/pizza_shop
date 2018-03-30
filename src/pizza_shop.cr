require "./pizza_shop/*"

include Pizza
include Shop

#
# Example Order:
#

# order = Shop::Order.new(
#   size: Size::Large,
#   toppings: [
#     Topping::Pepperoni,
#     Topping::Ranch,
#     Topping::Bacon,
#   ]
# )

def random_order
  r = Random.new
  random_size = r.rand(1..Size.names.size)
  random_size = Size.from_value(random_size - 1)

  random_toppings = [] of Topping

  rand_end = r.rand(1..Topping.names.size)
  while rand_end > 0 
    topping = r.rand(1..Topping.names.size)
    random_toppings << Topping.from_value(topping - 1)

    rand_end -= 1
  end

  Order.new(size: random_size, toppings: random_toppings)
end

counter = Counter.new

spawn do
  loop do
    spawn { counter.take_order }
    puts "Take a #{counter.finished.receive.to_s}"
  end
end

spawn do
  loop do
    order = random_order
    puts "Make a #{order.to_s}"
    spawn { counter.place_order(order) }
    sleep 0.5
  end
end

sleep



# def ping(pings, message)
#   pings.send message
# end

# def pong(pings, pongs)
#   message = pings.receive
#   pongs.send message
# end

# pings = Channel(String).new
# pongs = Channel(String).new
# spawn ping(pings), "passed message"
# spawn pong(pings, pongs)

# puts pongs.receive # => "passed message"