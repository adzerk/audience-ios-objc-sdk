import Foundation
import VelocidiSDK

// Event examples taken from https://docs.velocidi.com/collect/events
struct ExampleEvents {
    static let appViewJsonStr: String =
"""
{
  "clientId": "velocidi",
  "siteId": "velocidi.com",
  "type": "appView",
  "customFields": {
    "debug": "true",
    "role": "superuser",
  },
  "title": "Welcome Screen"
}
"""
    static let appViewJsonFoundationObject =  (try? VSDKUtil.tryParseJsonEventString(appViewJsonStr))!

    static let orderPlaceJsonStr =
"""
{
  "clientId": "velocidi",
  "siteId": "velocidi.com",
  "type": "orderPlace",
  "customFields": {
    "debug": "true",
    "role": "superuser"
  },
  "lineItems": [
    {
      "itemGroupId": "p125",
      "name": "My product",
      "brand": "Nike",
      "productType": "Shirts",
      "currency": "EUR",
      "promotions": [
        "WINTERSALE"
      ],
      "adult": false,
      "size": "S",
      "sizeSystem": "EU",
      "customFields": {
        "color": "blue"
      },
      "lineItemId": "li125zc",
      "productId": "p125zc",
      "total": 102.5,
      "subtotal": 85,
      "tax": 11.5,
      "shipping": 6,
      "sku": "p125zc-5",
      "discount": {
        "value": 5,
        "currency": "EUR"
      },
      "refund": 0,
      "quantity": 1,
      "subscriptionDuration": 180
    }
  ],
  "order": {
    "id": "or123",
    "currency": "EUR",
    "total": 102.5,
    "subtotal": 85,
    "tax": 11.5,
    "shipping": 6,
    "discount": {
      "value": 5,
      "currency": "EUR"
    },
    "refund": 0,
    "paymentMethod": "Visa",
    "shippingMethod": "UPS",
    "shippingCountry": "France",
    "promotions": [
      "WINTERSALE"
    ]
  }
}
"""
    static let orderPlaceJsonFoundationObject = (try? VSDKUtil.tryParseJsonEventString(orderPlaceJsonStr))!

    static let productViewJsonStr =
"""
{
  "clientId": "velocidi",
  "siteId": "velocidi.com",
  "type": "productView",
  "customFields": {
    "debug": "true",
    "role": "superuser"
  },
  "product": {
    "itemGroupId": "p125",
    "name": "My product",
    "brand": "Nike",
    "productType": "Shirts",
    "currency": "EUR",
    "promotions": [
      "WINTERSALE"
    ],
    "adult": false,
    "size": "S",
    "sizeSystem": "EU",
    "customFields": {
      "color": "blue"
    },
    "id": "p125zc",
    "price": 102.5,
    "gender": "male"
  }
}
"""

    static let productViewJsonFoundationObject = (try? VSDKUtil.tryParseJsonEventString(productViewJsonStr))!

    static let customJsonStr =
"""
{
  "clientId": "velocidi",
  "siteId": "velocidi.com",
  "type": "custom",
  "customFields": {
    "debug": "true",
    "role": "superuser"
  },
  "customType": "setReminder"
}
"""

    static let customJsonFoundationObject = (try? VSDKUtil.tryParseJsonEventString(customJsonStr))!

    static let allEvents = [
        (appViewJsonStr, appViewJsonFoundationObject),
        (orderPlaceJsonStr, orderPlaceJsonFoundationObject),
        (productViewJsonStr, productViewJsonFoundationObject),
        (customJsonStr, customJsonFoundationObject)
    ]
}
