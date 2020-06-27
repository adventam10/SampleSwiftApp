//
//  AvatarAPISpec.swift
//  ModelsTests
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Quick
import Nimble

@testable import Models

final class AvatarAPISpec: QuickSpec {

    override func spec() {
        // MARK: - AvatarAPIRequest

        describe("AvatarAPIRequest") {
            describe("baseURL") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns any URL") {
                        expect(api.baseURL).to(equal(URL(string: "https://joeschmoe.io/api")!))
                    }
                }
            }

            describe("method") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns get") {
                        expect(api.method).to(equal(.get))
                    }
                }
            }

            describe("path") {
                context("when AvatarAPIRequest is getAvatar") {
                    context("when type is random") {
                        let api = AvatarAPIRequest.getAvatar(type: .random)
                        it ("returns v1/random") {
                            expect(api.path).to(equal("v1/random"))
                        }
                    }

                    context("when type is randomMale") {
                        let api = AvatarAPIRequest.getAvatar(type: .randomMale)
                        it ("returns v1/male/random") {
                            expect(api.path).to(equal("v1/male/random"))
                        }
                    }

                    context("when type is randomFemale") {
                        let api = AvatarAPIRequest.getAvatar(type: .randomFemale)
                        it ("returns v1/female/random") {
                            expect(api.path).to(equal("v1/female/random"))
                        }
                    }

                    context("when type is named") {
                        let name = "name"
                        let api = AvatarAPIRequest.getAvatar(type: .named(name: name))
                        it ("returns v1/name") {
                            expect(api.path).to(equal("v1/\(name)"))
                        }
                    }

                    context("when type is namedMale") {
                        let name = "name"
                        let api = AvatarAPIRequest.getAvatar(type: .namedMale(name: name))
                        it ("returns v1/male/name") {
                            expect(api.path).to(equal("v1/male/\(name)"))
                        }
                    }

                    context("when type is namedFemale") {
                        let name = "name"
                        let api = AvatarAPIRequest.getAvatar(type: .namedFemale(name: name))
                        it ("returns v1/female/name") {
                            expect(api.path).to(equal("v1/female/\(name)"))
                        }
                    }
                }
            }

            describe("headerFields") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns empty") {
                        expect(api.headerFields).to(beEmpty())
                    }
                }
            }

            describe("parameter") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns empty") {
                        expect(api.parameter).to(beEmpty())
                    }
                }
            }

            describe("timeout") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns 65") {
                        expect(api.timeout).to(equal(65))
                    }
                }
            }

            describe("contentType") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns empty") {
                        expect(api.contentType).to(beEmpty())
                    }
                }
            }

            describe("accept") {
                context("when AvatarAPIRequest is getAvatar") {
                    let api = AvatarAPIRequest.getAvatar(type: .random)
                    it ("returns empty") {
                        expect(api.accept).to(beEmpty())
                    }
                }
            }
        }

        // MARK: - AvatarAPI

        describe("AvatarAPIR") {
            describe("getWeatherWithCityId") {
                let spy = APIClientSpy()
                let avatarType: AvatarAPIRequest.AvatarType = .random
                let api = AvatarAPI(apiClient: spy)
                api.getAvatar(avatarType: avatarType) { _ in }
                let passed = spy.sendPassedRequest as? AvatarAPIRequest
                it ("passes getAvatarWithType request to the API client") {
                    expect(passed).to(equal(.getAvatar(type: avatarType)))
                }
            }
        }
    }
}
