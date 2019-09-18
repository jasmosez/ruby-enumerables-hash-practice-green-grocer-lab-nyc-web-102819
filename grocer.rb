def consolidate_cart(cart)
  new = {}
  cart.reduce { |cart_memo, cart_item|
    item_keys = cart_item.keys
    p item_keys
    item_keys.reduce({}) { |item_keys_memo, keys_item|
      puts new[keys_item]
      if new[keys_item] 
	      new[keys_item][:count] =+ 1
	    else
	      new[keys_item] = item[keys_item]
	      new[keys_item][:count] = 1
   	  end
    }
  }
end


def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
