 module Shop
  include Pizza

  class Order
    getter :size, :toppings, :instructions
    def initialize(
      @size : Size = Size::Small,
      @toppings : Array(Topping) = [Topping::Cheese],
      @instructions : Array(String) = [] of String
    ) end

    def to_s
      "#{@size} pizza with #{@toppings.to_penultimate_s}"
    end
  end

  class Counter
    getter :orders, :finished

    @orders = Channel(Order).new
    @finished = Channel(Order).new

    def place_order(order)
      @orders.send order
    end

    def take_order
      order = @orders.receive
      sleep Random.new.rand(0.1..0.5)
      @finished.send order
    end
  end
end