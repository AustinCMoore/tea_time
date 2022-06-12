class SubscriptionsSerializer
  include JSONAPI::Serializer
  attributes :id,
              :active_subs,
              :inactive_subs
end
