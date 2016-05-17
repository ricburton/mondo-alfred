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


workflow = Alfredo::Workflow.new

merchants = []


# mondo.transactions(expand: [:merchant], limit: 20, since: "2015-08-10T23:00:00Z")
mondo.transactions.reverse.each do |transaction|
  if transaction.merchant
    merchants << transaction.merchant
  end
end

merchants.uniq{|m|m.name}.each do |merchant|

  #   amount_check = Money.new(transaction.local_amount.fractional,transaction.local_currency).to_s
  # if amount_check[0,1] == "-"
  #   amount_check.sub!('-','-£')
  # else
  #   amount_check = "£" + amount_check
  # end
  # amount = amount_check
  # merchant_clipped = ""

  emoji = "🙄"
  if merchant.emoji
    catch :NoMethodError do
      emoji = "🙄"
    end
    emoji = merchant.emoji
  end


  # if merchant.emoji
  #   emoji = merchant.emoji
  # else 
  #   emoji = "🙄"
  # end
  # end 

  workflow << Alfredo::Item.new({
    # title: amount_check
    # title: "#{merchant_clipped}" + "     " + " #{amount}",#,#, #merchant[:name]
    # title: "#{amount} • #{merchant_clipped}",#, #merchant[:name]
    title: "#{merchant.name}",
    icon_path: emoji + ".png"
  })
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