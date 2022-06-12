require 'rails_helper'

RSpec.describe 'subscriptions' do
  it "creates a subscription" do
    customer = Customer.create!(first_name: "First Name", last_name: "Last Name", email: "fake@email.com", address: "Fake Address")
    tea = Tea.create!(title: "Title", description: "This description can be very long because it is text", temperature: 180, brew_time: 300)
    count = Subscription.all.count
    post "/api/v1/subscriptions", :params => {
                                            customer_id: customer.id,
                                            tea_id: tea.id,
                                            title: "Title",
                                            price: 399,
                                            status: "subscribed",
                                            frequency: 1
                                          }

    new_count = Subscription.all.count
    count += 1
    expect(response).to be_successful
    expect(new_count).to eq(count)
  end

  it "cancels a subscription" do
    customer = Customer.create!(first_name: "First Name", last_name: "Last Name", email: "fake@email.com", address: "Fake Address")
    tea = Tea.create!(title: "Title", description: "This description can be very long because it is text", temperature: 180, brew_time: 300)
    subscription = Subscription.create!(customer_id: customer.id, tea_id: tea.id, title: "Title", price: 399, status: "subscribed", frequency: 1)

    patch "/api/v1/subscriptions/#{subscription.id}"
    updated_subscription = Subscription.find(subscription.id)

    expect(response).to be_successful
    expect(updated_subscription.status).to eq("unsubscribed")
  end

  it "has all subscriptions for a customer" do
    customer_1 = Customer.create!(first_name: "First Name", last_name: "Last Name", email: "fake@email.com", address: "Fake Address")
    customer_2 = Customer.create!(first_name: "First Name", last_name: "Last Name", email: "false@email.com", address: "Fake Address")
    tea_1 = Tea.create!(title: "Tea 1", description: "This description can be very long because it is text", temperature: 180, brew_time: 300)
    tea_2 = Tea.create!(title: "Tea 2", description: "This description can be very long because it is text", temperature: 150, brew_time: 360)
    subscription_1 = Subscription.create!(customer_id: customer_1.id, tea_id: tea_1.id, title: "Title", price: 399, status: "subscribed", frequency: 1)
    subscription_2 = Subscription.create!(customer_id: customer_1.id, tea_id: tea_2.id, title: "Title", price: 399, status: "unsubscribed", frequency: 1)
    subscription_3 = Subscription.create!(customer_id: customer_2.id, tea_id: tea_1.id, title: "Title", price: 399, status: "subscribed", frequency: 1)
    subscription_4 = Subscription.create!(customer_id: customer_2.id, tea_id: tea_2.id, title: "Title", price: 399, status: "unsubscribed", frequency: 1)

    get "/api/v1/subscriptions", :params => {customer_id: customer_1.id}
    expect(response).to be_successful
    subscriptions = JSON.parse(response.body, symbolize_names: true)

    expect(subscriptions).to be_a(Hash)
  end
end
