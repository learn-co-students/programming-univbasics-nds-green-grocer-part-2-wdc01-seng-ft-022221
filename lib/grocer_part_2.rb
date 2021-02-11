require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  index = 0 
  while index < coupons.length 
  cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
  couponed_item = "#{coupons[index][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item, cart)
  if cart_item && cart_item[:count] >= coupons[index][:num]
    if cart_item_with_coupon 
      cart_item_with_coupon[:count] += coupons[index][:num]
      cart_item[:count] -= coupons[index][:num]
    else cart_item_with_coupon = {
      :item => couponed_item,
      :price => coupons[index][:cost] / coupons[index][:num],     
      :clearance => cart_item[:clearance],
      :count => coupons[index][:num]
    }
    cart.push(cart_item_with_coupon)
    cart_item[:count] -= coupons[index][:num]
    end
end
  index += 1
end
cart
end

def apply_clearance(cart)
  index = 0 
  while index < cart.length 
    if cart[index][:clearance] == true 
      cart[index][:price] = cart[index][:price] - (cart[index][:price] * 0.20).round(2)
    end
  index += 1
end
cart
end

def checkout(cart, coupons)
  consolidated_checkout_cart = consolidate_cart(cart)
  checkout_cart_with_coupons = apply_coupons(consolidated_checkout_cart, coupons)
  discounted_checkout_cart = apply_clearance(checkout_cart_with_coupons)
  grand_total = 0 
  index = 0 
  while index < discounted_checkout_cart.length 
  total = discounted_checkout_cart[index][:price] * discounted_checkout_cart[index][:count]
  grand_total = grand_total + total
    if grand_total >= 100 
      grand_total = grand_total - (grand_total * 0.10).round(2)
    end
  index += 1
end
grand_total
end
