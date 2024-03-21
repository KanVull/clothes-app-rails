class Current < ActiveSupport::CurrentAttributes
  attribute :cart

  resets { cart = nil }
end
