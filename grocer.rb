def consolidate_cart(cart)

  # step through each item in cart array and map it to a new hash
  cart.reduce({}) { |new_hash, cart_item_hash|
    
    # create an array of the keys of the hash that is an element of cart
    cart_item_keys = cart_item_hash.keys
    
    # iterate through cart_item_keys array and map to the new hash
    cart_item_keys.reduce({}) { |inner_hash, current_key|
      if new_hash[current_key] 
	      new_hash[current_key][:count] += 1
	    else
	      new_hash[current_key] = cart_item_hash[current_key]
	      new_hash[current_key][:count] = 1
   	  end
    }
    
  # need to return the new hash!
  new_hash  
  }
end


def apply_coupons(cart, coupons)
 
  # transform coupons array to be hash similar in structure to cart hash
  coupons_hash = coupons.reduce({}) { |new_coupons_hash, coupon_array_hash_element|
    new_coupons_hash[coupon_array_hash_element[:item]] = {
      :num => coupon_array_hash_element[:num], 
      :cost => coupon_array_hash_element[:cost]
    }
    
    new_coupons_hash
  }
  

  # get the value of the :item key for each element of the coupons array
  items_with_coupons = coupons.map { |coupon| coupon[:item] }
  

  # use the list of items that have coupons to lookup items in our cart
  items_with_coupons.reduce({}) { |new_hash, item_having_coupon|
  
    # if the item with a coupon is in our cart
    # and if our cart count of that item is enough to make use of coupon
    
    if cart[item_having_coupon] && cart[item_having_coupon][:count] >= coupons_hash[item_having_coupon][:num]
    
      # apply each coupon!     
      # If we've applied a coupon for this item before
      if cart["#{item_having_coupon} W/COUPON"]
        # Increment appropriately
        cart["#{item_having_coupon} W/COUPON"][:count] += coupons_hash[item_having_coupon][:num]
        
      else
        # If it's a coupon for a new item
        # Create new item (W/COUPON) in cart
        # Include appropriate price, clearance and count
        
        cart["#{item_having_coupon} W/COUPON"] = {
          :price => (coupons_hash[item_having_coupon][:cost]/coupons_hash[item_having_coupon][:num]),
          :clearance => cart[item_having_coupon][:clearance],
          :count => coupons_hash[item_having_coupon][:num]
        }
      end
      
      # No matter what, reduce count for original item
      cart[item_having_coupon][:count] -= coupons_hash[item_having_coupon][:num]
    
    end
  
  }
  
  cart
end




def apply_clearance(cart)
  # create an array of the keys of the cart
  cart_item_keys = cart.keys
  
  cart_item_keys.reduce({}) { |memo, key|
    if cart[key][:clearance] == true
      cart[key][:price] = (cart[key][:price]*0.8).round(2)
    end
  }
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  puts "clearanced_cart"
  puts clearanced_cart
  
  # create an array of the keys of clearanced_cart
  clearanced_cart_item_keys = clearanced_cart.keys
 
  #tabulate assert_not_equal
  subtotal = clearanced_cart_item_keys.reduce(0) { |sum, key|
    sum += clearanced_cart[key][:price]*clearanced_cart[key][:count]
  }
  
  #check for additional discount. Apply if appropriate
  puts subtotal
  if subtotal > 100
    subtotal -= (subtotal*0.1).round(2)
  end
  return subtotal
end
