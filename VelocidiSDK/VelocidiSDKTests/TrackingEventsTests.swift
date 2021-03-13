import UIKit
import Quick
import Nimble
import Mockingjay
import VelocidiSDK

class TrackingEventsTests: QuickSpec {
    // swiftlint:disable function_body_length
    override func spec() {
        super.spec()
        func serializesCorrectly(event: VSDKTrackingEvent) -> Bool? {
            var success: Bool?
            do {
                _ = try JSONModel.init(data: event.toJSONData())
                success = true
            } catch {
                success = false
            }
            return success
        }

        let product = VSDKProduct()
        product.productId = "1"
        product.name = "1"
        product.brand = "brand1"
        product.category = "cat1"
        product.price = 1.0

        describe("VSDKAddToCart") {
            let event = VSDKAddToCart()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKAppView") {
            let event = VSDKAppView()
            event.siteId = "0"
            event.clientId = "0"
            event.title = "a"

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKOrderPlace") {
            let event = VSDKOrderPlace()
            event.siteId = "0"
            event.clientId = "0"
            let lineItem = VSDKLineItem()
            lineItem.id = "1"
            lineItem.currency = "EUR"
            lineItem.total = 1.0
            lineItem.subtotal = 1.0
            lineItem.tax = 1.0
            lineItem.shipping = 1.0
            let order = VSDKOrder()
            order.id = "1"
            order.currency = "EUR"
            order.total = 1.0
            order.subtotal = 1.0
            order.tax = 1.0
            order.shipping = 1.0
            event.order = order
            event.lineItems = NSMutableArray(array: [lineItem])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKPageView") {
            let event = VSDKPageView()
            event.siteId = "0"
            event.clientId = "0"
            event.location = "a"
            event.title = "b"

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKProductClick") {
            let event = VSDKProductClick()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKProductCustomization") {
            let event = VSDKProductCustomization()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])
            let cust = VSDKCustomization()
            cust.name = "a"
            cust.price = 1.0
            event.productCustomization = cust

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKProductFeedback") {
            let event = VSDKProductFeedback()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])
            event.rating = 2.5

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKProductImpression") {
            let event = VSDKProductImpression()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKProductView") {
            let event = VSDKProductView()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKProductViewDetails") {
            let event = VSDKProductViewDetails()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKRemoveFromCart") {
            let event = VSDKRemoveFromCart()
            event.siteId = "0"
            event.clientId = "0"
            event.products = NSMutableArray(array: [product])

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }

        describe("VSDKSearch") {
            let event = VSDKSearch()
            event.siteId = "0"
            event.clientId = "0"
            event.query = "a"

            it("should serialize correctly") {
                expect(serializesCorrectly(event: event)).to(beTrue())
            }
        }
    }

}
