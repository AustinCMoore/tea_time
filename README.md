# TeaTime
## Welcome to the TeaTime API
 + This API was built as part of the take home tech challenge for The Turing School of Software Design's graduation requirements

## Available Endpoints
  + base `/api/v1`

  + Subscriptions
  + Post `/subscriptions`
    + takes customer_id, tea_id, title, price, status, and frequency
    + returns 200 response, creates a subscription for a given tea and customer
  + Patch `/subscriptions/subscription_id`
    + takes subscription_id
    + returns 200 response, changes status from subscribed to unsubscribed
  + Get `/subscriptions`
    + takes customer_id
    + returns JSON payload with two arrays, one with active subs and one with inactive subs, and each subs info is included in the payload

## Versions
* Ruby version - 2.7.4
* Rails - 5.2.7

## DB Schema
![image](https://user-images.githubusercontent.com/92219945/173435136-4350e499-7ac8-489b-bc34-18291adf13b7.png)
