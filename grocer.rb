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
 
 # transform coupons hash to be similar in structure to cart hash
 coupons.reduce({}) { |new_coupons_hash, coupon_array_hash_element|
   new_coupons_hash[coupon_array_hash_element[:item]] = {coupon_array_hash_element[:num], coupon_array_hash_element[:cost]}
  puts new_coupons_hash
  new_coupons_hash
     
   }
 
 
 
  # get the list of items for which we have coupons
  # i.e. get the value of the :item key for each element of the coupons array
  # items_with_coupons = coupons.map { |coupon| coupon[:item] }
  
  # use the list of items that have coupons to lookup items in our cart
  items_with_coupons.reduce({}) { |new_hash, item_having_coupon
    # if the item with a coupon is in our cart
    
   #  if cart[item_having_coupon]
      
      # and if we have count is enough to make use of coupon
    #   if cart[item_having_coupon][:count] >= 
    
    # I am looking for the element in an array where the value of the :item key is item_having_coupon
    
    
 # }
  
  # apply each coupon such that it our cart hash
  
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
