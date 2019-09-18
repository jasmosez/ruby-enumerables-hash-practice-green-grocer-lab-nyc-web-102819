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
 
  # transform coupons array to be hash similar in structure to cart hash
  coupons_as_hash = coupons.reduce({}) { |new_coupons_hash, coupon_array_hash_element|
    new_coupons_hash[coupon_array_hash_element[:item]] = {
      :num => coupon_array_hash_element[:num], 
      :cost => coupon_array_hash_element[:cost]
    }
    
    new_coupons_hash
  }
  
  # consolidate coupons_as_hash in case there are multiple coupons for the same item
  
    #step through each item in cart array and map it to a new hash
    coupons_as_hash = coupons_as_hash.reduce({}) { |new_hash, coupon_item_hash|
      
      # create an array of the keys of the hash that is an element of cart
      coupon_item_keys = coupon_item_hash.keys
      
      # iterate through cart_item_keys array and map to the new hash
      coupon_item_keys.reduce({}) { |inner_hash, current_key|
        if new_hash[current_key] 
  	      new_hash[current_key][:num] += 1
  	    else
  	      new_hash[current_key] = cart_item_hash[current_key]
  	      new_hash[current_key][:num] = 1
     	  end
      }
      
    # need to return the new hash!
    new_hash  
    }







  # get the list of items for which we have coupons
  # i.e. get the value of the :item key for each element of the coupons array
  items_with_coupons = coupons.map { |coupon| coupon[:item] }
  
  
  # use the list of items that have coupons to lookup items in our cart
  items_with_coupons.reduce({}) { |new_hash, item_having_coupon|
  
    # if the item with a coupon is in our cart
    # and if our cart count of that item is enough to make use of coupon
    if cart[item_having_coupon] && cart[item_having_coupon][:count] >= coupons_as_hash[item_having_coupon][:num]
    
      # apply each coupon such that it our cart hash    
      # 1. create new item in cart for item with coupon with appropriate price, clearance and count
      cart["#{item_having_coupon} W/COUPON"] = {
        :price => (coupons_as_hash[item_having_coupon][:cost]/coupons_as_hash[item_having_coupon][:num]),
        :clearance => cart[item_having_coupon][:clearance],
        :count => coupons_as_hash[item_having_coupon][:num]
      }
      # 2. reduce count for original item
      cart[item_having_coupon][:count] -= coupons_as_hash[item_having_coupon][:num]
    end
  
  }
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
