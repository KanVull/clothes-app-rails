class Current < ActiveSupport::CurrentAttributes
  attribute :cart
  attribute :user

  resets { cart = nil }
  resets { user = nil }
end
