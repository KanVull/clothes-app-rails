class OrdersMailer < ApplicationMailer
  def order_created(order)
    @link = order_url(order)
    @catalog_url = catalog_url
    mail(to: order.email, subject: "Store - Order created")
  end
end
