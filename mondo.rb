# source "/Users/richardburton/.bashrc"
# ruby mondo.rb

# require 'mondo-alfred'
require 'mondo'
# require 'bundler'
# bundle config local.rack ~/Work/git/rac

# gem 'mondo', :path => "~/Dropbox/dev/mondo-ruby"
require 'money'
require 'alfredo'

YOUR_TOKEN = ''
YOUR_ACCOUNT_ID = ''

mondo = Mondo::Client.new(
  token: YOUR_TOKEN,
  account_id: YOUR_ACCOUNT_ID
)

mondo.api_url = 'https://api.getmondo.co.uk/'

Money.use_i18n = false

balance = Money.new(mondo.balance.balance.fractional, mondo.balance.currency)
# # spend_today = Money.new(mondo.balance.balance.fractional)

# # puts '💷' + balance.to_s
# # puts '£' + balance.to_s + '💷' + ' £' + 


workflow = Alfredo::Workflow.new

##TODO 
#Fix Gem
#Features
#No internet
#Ordering

workflow << Alfredo::Item.new({
  title: 'Balance: £' + balance.to_s,
  icon_path: '💷.png',
  arg: 'hello',
  uid: '1'
  # subtitle: "Open this page in your browser"#,
  # arg: url + el["https://getmondo.co.uk"]
})

# Spend Today
todays_transactions = mondo.transactions(since:Date.today)
spent_today = 0
todays_transactions.each do |transaction| 
  spent_today += transaction.amount.fractional 
end

spending = Money.new(spent_today, 'GBP').to_s

if spending[0,1] == "-"
  spending.sub!('-','-£')
else
  spending = "£" + spending
end

workflow << Alfredo::Item.new({
  # title: 'Spent today: £' + mondo.balance.spent_today.fractional.to_s,
  title: 'Spent today: ' + spending,
  icon_path: '📅.png',
  arg: 'hello',
  uid: '2'#,
  #type: ''
  # type: .
  # subtitle: "Open this page in your browser"#,
  # arg: url + el["https://getmondo.co.uk"]
})


if mondo.cards.first.status == "ACTIVE"
  workflow << Alfredo::Item.new({
    title: 'Freeze',
    icon_path: '⛄️.png',
    arg: 'freeze',
    uid: '3'
  })
else
  workflow << Alfredo::Item.new({
    title: 'Defrost',
    icon_path: '🔥.png',
    arg: 'unfreeze',
    uid: '3'
  })
end



# 📅.png
# spend_today = Money.new(mondo.balance.balance.fractional)

#Recent transactions
workflow << Alfredo::Item.new({
  title: 'Recent Transactions',
  icon_path: '💳.png',
  arg: 'hello',
  uid: '4'
  # type: ''
  # type: .
  # subtitle: "Open this page in your browser"#,
  # arg: url + el["https://getmondo.co.uk"]
})



# mondo.transactions(expand: [:merchant], limit: 20, since: "2015-08-10T23:00:00Z")
mondo.transactions.reverse[0..10].each do |transaction|
  amount_check = Money.new(transaction.local_amount.fractional,transaction.local_currency).to_s
  if amount_check[0,1] == "-"
    amount_check.sub!('-','-£')
  else
    amount_check = "£" + amount_check
  end
  amount = amount_check
  merchant_clipped = ""
  if transaction.merchant
    merchant_clipped = transaction.merchant.name
  end
  emoji = "🙄"
  if transaction.merchant
    emoji = transaction.merchant.emoji
  end
  workflow << Alfredo::Item.new({
    # title: amount_check
    # title: "#{merchant_clipped}" + "     " + " #{amount}",#,#, #merchant[:name]
    title: "#{amount} • #{merchant_clipped}",#, #merchant[:name]
    icon_path: emoji + ".png"
  })
#   end
end
# #Uniques
# # mondo.transactions.last.merchant
# #<Mondo::Merchant merch_000090ER75UzBxejYTIb4r {"id"=>"merch_000090ER75UzBxejYTIb4r", "group_id"=>"grp_00008yEdfHhvbwnQcsYryL", "created"=>"2015-09-19T09:42:16Z", "name"=>"Department Of Coffee And Social Affairs", "logo"=>"http://avatars.io/twitter/deptofcoffee/?size=large", "address"=>{"address"=>"14-16 Leather Ln", "city"=>"London", "region"=>"Greater London", "country"=>"GB", "postcode"=>"EC1N 7SU", "latitude"=>51.519348553897686, "longitude"=>-0.1090317964553833}}>

# merchants = []

# mondo.transactions.each do |transaction|
#   merchants << transaction.merchant
# end

# unique_merchants = merchants.uniq!

# unique_merchants.each do |unique_merchant|

# workflow << Alfredo::Item.new({
#   title: unique_merchant.name, #merchant[:name]
#   # icon_path: ???
#   })

# end

puts workflow.output!


# ======================

# xml = <<EOS
# <xml>
# <items>
#   <item>
#    <title>#{'£' + balance.to_s}</title>
#   </item>
#   <item>
#    <title>#{'£' + balance.to_s}</title>
#   </item>
# </items>
# </xml>
# EOS

# puts xml