module KaminariHelper
  def kaminari_page_outer?(page)
    page.left_outer? || page.right_outer? || page.inside_window?
  end
end
