class OrdersMailerPreview < ActionMailer::Preview
  def order_created
    order = Order.first
    OrdersMailer.order_created(order)
  end
end
