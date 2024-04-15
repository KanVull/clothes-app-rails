module ProductCategoriesHelper
  def render_categories(categories)
    categories.map do |category|
      render(partial: "shared/category", locals: { category: category })
    end.join.html_safe
  end

  def nested_categories(categories, level = 0, category_list = [])
    categories.each do |category|
      category.name = "|- " * level + category.name
      category_list.append(category)
      if category.has_children?
        nested_categories(category.children, level+1, category_list)
      end
    end
    category_list
  end
end
