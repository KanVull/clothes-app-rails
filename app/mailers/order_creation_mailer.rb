class OrderCreationMailer < ApplicationMailer
  def send_order_link_to(email, order_link)
    @link = order_link
    mail(to: email, subject: "Store - Order created")
  end
end
