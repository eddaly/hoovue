module ProductsHelper

  def toggle_like_button(product, current_user)
    if current_user
    if current_user.flagged?(product, :like)
      
      link_to "Unlike", like_product_path(product)
    else
      
      link_to "Like +", like_product_path(product)
      
    end
  end
    
  end
  
  
  def toggle_complete_button(product, current_user)
    if current_user
    if current_user.flagged?(product, :complete)
      
      link_to "Vote team uncomplete", complete_product_path(product), class: "actions"
    else
      
      link_to "Vote team this complete", complete_product_path(product), class: "actions"
      
    end
    
  end
end
end
