class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])
    subscription = Subscription.create!(customer_id: customer.id,
                                        tea_id: tea.id,
                                        title: params[:title],
                                        price: params[:price],
                                        status: params[:status],
                                        frequency: params[:frequency]
                                        )
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(status: "unsubscribed")
  end

  def index
    customer = Customer.find(params[:customer_id])
    active_subs = customer.subscribed
    inactive_subs = customer.unsubscribed
    subs = SubscriptionsPoro.new(active_subs, inactive_subs)

    render json: SubscriptionsSerializer.new(subs)
  end
end
