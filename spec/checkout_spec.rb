require "./lib/checkout.rb"

describe Checkout do
  subject(:order) { Checkout.new({ promo_one: true, promo_two: true, discount: true }) }

  describe 'Check all promotions' do
    context 'Calculate basket of A,B,C' do
      before do
        [1, 2, 3].each { |item| order.scan(item) }
      end

      it { expect(order.total).to eq 100 }
    end

    context 'Calculate basket of B,A,B,A,A' do
      before do
        [2, 1, 2, 1, 1].each { |item| order.scan(item) }
      end

      it { expect(order.total).to eq 110 }
    end

    context 'Calculate basket of C,B,A,A,D,A,B' do
      before do
        [3, 2, 1, 1, 4, 1, 2].each { |item| order.scan(item) }
      end

      it { expect(order.total).to eq 155 }
    end

    context 'Calculate basket of C,A,D,A,A' do
      before do
        [3, 1, 4, 1, 1].each { |item| order.scan(item) }
      end

      it { expect(order.total).to eq 140 }
    end
  end
end
