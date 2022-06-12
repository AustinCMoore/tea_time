class SubscriptionsPoro
  attr_reader :id,
              :active_subs,
              :inactive_subs

  def initialize(active_subs, inactive_subs)
    @id = nil
    @active_subs = active_subs
    @inactive_subs = inactive_subs
  end
end
