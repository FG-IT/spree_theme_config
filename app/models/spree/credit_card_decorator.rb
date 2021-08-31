module Spree
  module CreditCardDecorator
    def self.prepended(base)
      base.with_options if: :require_card_numbers?, on: :create do
        validates :number, test_credit_card: true
      end
    end
  end
end
