class OrdersMailer < ApplicationMailer
  def order_created(order)
    @link = order_by_uuid_url(uuid: order.uuid)
    @catalog_url = catalog_url
    mail(to: order.email, subject: "Store - Order created")
  end
end
