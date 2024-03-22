class OrdersMailer < ApplicationMailer
  def order_created(order)
    @link = order_url(order)
    mail(to: order.email, subject: "Store - Order created")
  end
end
