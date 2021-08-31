##
# Validates if its test credit card number
class TestCreditCardValidator < ActiveModel::EachValidator


  def validate_each(record, attribute, value)
    # value = record[:base]
    if value && test_card(value)
      record.errors.add(attribute, "Credit card is invalid, please try another one.")
    end
  end

  def test_card(number)
    test_numbers = %w{
                      378282246310005 371449635398431 378734493671000
                      2223000048400011 2223520043560014 5555555555554444
                      4111111111111111 4012888888881881 4222222222222
                      4005519200000004 4009348888881881 4012000033330026
                      4012000077777777 4217651111111119 4500600000000061
                      4000111111111115 5454545454545454 5105105105105100
                      }
    test_numbers.include?(number)
  end

end
