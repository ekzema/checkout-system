class Checkout
  STORE = [
    { id: 1, name: 'Apple', price: 30 },
    { id: 2, name: 'Plum', price: 20 },
    { id: 3, name: 'Orange', price: 50 },
    { id: 4, name: 'Banana', price: 15 }
  ].freeze

  def initialize(attr = {})
    @promotions = attr
    @scanned = []
    @total = 0
  end

  def scan(item)
    @scanned << item if STORE.map { |x| x[:id] }.include?(item)
  end

  def total
    @promotions.map { |k, v| send(k) if v && self.class.private_method_defined?(k) }
    not_promotional
    @promotions[:discount] && @total > 150 ? @total -= 20 : @total
  end

  def clean_items
    @scanned = []
  end

  private

  def sum_promo(id, amount, discount)
    price = STORE.find { |item| item[:id] == id }&.dig(:price)
    count = @scanned.select { |i| i == id }.count
    @scanned.delete(id)
    @total += ((count - (count % amount)) / amount) * discount + ((count % amount) * price)
  end

  def promo_one
    sum_promo(1, 3, 75)
  end

  def promo_two
    sum_promo(2, 2, 35)
  end

  def not_promotional
    @scanned.each { |id| @total += STORE.find { |item| item[:id] == id }&.dig(:price) }
  end
end

