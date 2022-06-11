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
end
