def consolidate_cart(cart)

  #step through each item in cart array and map it to a new hash
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
  # get the list of items for which we have coupons
  # i.e. get the value of the :item key for each element of the coupons array
  puts coupons.map { |item|
    item[:item]
  }
  
  # compare our cart to the list of items that have coupons
  # apply each coupon such that it our cart hash
  
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
