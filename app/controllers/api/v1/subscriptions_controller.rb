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
end
