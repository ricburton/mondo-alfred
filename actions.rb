# require 'mondo-alfred'
require 'mondo'
# gem 'secure_headers', :path => "~/workspace/secureheaders"
require 'money'
require 'alfredo'

spacer = "




































































  "

YOUR_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaSI6Im9hdXRoY2xpZW50XzAwMDA5NFB2SU5ER3pUM2s2dHo4anAiLCJleHAiOjE0NjA5Nzk5ODEsImlhdCI6MTQ2MDgwNzE4MSwianRpIjoidG9rXzAwMDA5N0Z1NVV2WjVxU2pUak40YzUiLCJ1aSI6InVzZXJfMDAwMDk3RnFrekEzQnJ1akFHQXNNYiIsInYiOiI0In0.M7H-Vm_RQjuq3AEffhoZQJ5-5xPAag70tRcvSzQAb5o'
YOUR_ACCOUNT_ID = 'acc_000097FquvL0GC22VvYvnV'

mondo = Mondo::Client.new(
  token: YOUR_TOKEN,
  account_id: YOUR_ACCOUNT_ID
)

mondo.api_url = 'https://staging-api.getmondo.co.uk/'

Money.use_i18n = false


query = ARGV[0]

update = ""
garbage = ""

if query == 'freeze'
  update = "⛄️ Card frozen" + spacer
  puts update
  garbage = mondo.cards.first.freeze
end

if query == 'unfreeze'
  update = "🔥 Card defrosted" + spacer
  puts update
  garbage = mondo.cards.first.unfreeze
end

# do 
#   mondo.cards.first.freeze
# end


# puts ''

# if query == 'freeze'
#   mondo.cards.first.freeze
#   # update = '⛄️ Card frozen'
# end

# if query == 'unfreeze'
#   mondo.cards.first.unfreeze
#   # update = '🔥 Card unfrozen'
# end

