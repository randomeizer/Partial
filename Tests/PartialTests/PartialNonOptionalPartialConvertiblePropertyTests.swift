import Quick
import Nimble

@testable
import Partial

final class PartialNonOptionalPartialConvertiblePropertyTests: QuickSpec {

    override func spec() {
        describe("Partial") {
            context("wrapping a type with a non-optional `PartialConvertible` property") {
                struct Wrapped {
                    struct Embedded: PartialConvertible, Equatable {
                        let string: String
                        init(string: String) {
                            self.string = string
                        }
                        init(partial: Partial<Wrapped.Embedded>) throws {
                            string = try partial.value(for: \.string)
                        }
                    }
                    let embedded: Embedded
                }

                context("initialised without a backing value") {
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        partial = Partial()
                    }

                    context("value(for:)") {
                        it("should throw a keyPathNotSet error") {
                            let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                            expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                        }
                    }

                    context("partialValue(for:)") {
                        it("should return a partial without a value set") {
                            let result = partial.partialValue(for: \.embedded)
                            expect { try? result.value(for: \.string) }.to(beNil())
                        }

                        it("should return a partial without a backing value") {
                            let result = partial.partialValue(for: \.embedded)
                            expect(result.backingValue).to(beNil())
                        }
                    }

                    context("the subscript") {
                        var result: Wrapped.Embedded?

                        beforeEach {
                            result = partial[\.embedded]
                        }

                        it("should return `nil`") {
                            expect(result).to(beNil())
                        }
                    }

                    #if swift(>=5.1)
                    context("dynamic member lookup") {
                        var result: Wrapped.Embedded?

                        beforeEach {
                            result = partial.embedded
                        }

                        it("should return `nil`") {
                            expect(result).to(beNil())
                        }
                    }
                    #endif

                    context("with the value set via `setValue(_:for:)`") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }

                    context("with the value set via the subscript") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial[\.embedded] = valueSet
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }

                    #if swift(>=5.1)
                    context("with the value set via dynamic member lookup") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.embedded = valueSet
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }
                    #endif

                    context("with the value set to a partial via `setValue(_:for:)`") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(unwrappedValue))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect { try result.value(for: \.string) } == valueSet[\.string]
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should throw a keyPathNotSet error") {
                                    let expectedError = Partial<Wrapped>.Error.keyPathNotSet(\.embedded)
                                    expect { try partial.value(for: \.embedded) }.to(throwError(expectedError))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial without a value set") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect { try? result.value(for: \.string) }.to(beNil())
                                }

                                it("should return a partial without a backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue).to(beNil())
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return `nil`") {
                                    expect(result).to(beNil())
                                }
                            }
                        }
                        #endif
                    }
                }

                context("initialised with a backing value") {
                    var backingValue: Wrapped!
                    var partial: Partial<Wrapped>!

                    beforeEach {
                        backingValue = Wrapped(embedded: Wrapped.Embedded(string: "backing-test"))
                        partial = Partial(backingValue: backingValue)
                    }

                    context("value(for:)") {
                        it("should not throw an error") {
                            expect { try partial.value(for: \.embedded) }.toNot(throwError())
                        }

                        it("should return the value from the backing value") {
                            expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                        }
                    }

                    context("partialValue(for:)") {
                        it("should return a partial backed by the value from the backing value") {
                            let result = partial.partialValue(for: \.embedded)
                            expect(result.backingValue) == backingValue.embedded
                        }
                    }

                    context("the subscript") {
                        var result: Wrapped.Embedded?

                        beforeEach {
                            result = partial[\.embedded]
                        }

                        it("should return the value from the backing value") {
                            expect(result) == backingValue.embedded
                        }
                    }

                    #if swift(>=5.1)
                    context("dynamic member lookup") {
                        var result: Wrapped.Embedded?

                        beforeEach {
                            result = partial.embedded
                        }

                        it("should return the value from the backing value") {
                            expect(result) == backingValue.embedded
                        }
                    }
                    #endif

                    context("with the value set via `setValue(_:for:)`") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                        }
                        #endif
                    }

                    context("with the value set via the subscript") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial[\.embedded] = valueSet
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                        }
                        #endif
                    }

                    #if swift(>=5.1)
                    context("with the value set via dynamic member lookup") {
                        var valueSet: Wrapped.Embedded!

                        beforeEach {
                            valueSet = Wrapped.Embedded(string: "test")
                            partial.embedded = valueSet
                        }

                        context("value(for:)") {
                            it("should not throw an error") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return the set value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(valueSet))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the a partial wrapping the set value") {
                                let result = partial.partialValue(for: \.embedded)
                                expect(result.backingValue) == valueSet
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return the set value") {
                                expect(result) == valueSet
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                        }
                        #endif
                    }
                    #endif

                    context("with the value set to a partial via `setValue(_:for:)`") {
                        var unwrappedValue: Wrapped.Embedded!
                        var valueSet: Partial<Wrapped.Embedded>!

                        beforeEach {
                            unwrappedValue = Wrapped.Embedded(string: "test")
                            valueSet = Partial<Wrapped.Embedded>()
                            valueSet.setValue(unwrappedValue.string, for: \.string)
                            partial.setValue(valueSet, for: \.embedded)
                        }

                        context("value(for:)") {
                            it("should not throw") {
                                expect { try partial.value(for: \.embedded) }.toNot(throwError())
                            }

                            it("should return an unwrapped value") {
                                expect { try partial.value(for: \.embedded) }.to(equal(unwrappedValue))
                            }
                        }

                        context("partialValue(for:)") {
                            it("should return the set partial") {
                                let result = partial.partialValue(for: \.embedded)
                                expect { try result.value(for: \.string) } == valueSet[\.string]
                            }
                        }

                        context("the subscript") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial[\.embedded]
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }

                        #if swift(>=5.1)
                        context("dynamic member lookup") {
                            var result: Wrapped.Embedded?

                            beforeEach {
                                result = partial.embedded
                            }

                            it("should return an unwrapped value") {
                                expect(result).to(equal(unwrappedValue))
                            }
                        }
                        #endif

                        context("then removed with removeValue(for:)") {
                            beforeEach {
                                partial.removeValue(for: \.embedded)
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        context("then removed via the subscript") {
                            beforeEach {
                                partial[\.embedded] = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            #if swift(>=5.1)
                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                            #endif
                        }

                        #if swift(>=5.1)
                        context("then removed via dynamic member lookup") {
                            beforeEach {
                                partial.embedded = nil
                            }

                            context("value(for:)") {
                                it("should not throw an error") {
                                    expect { try partial.value(for: \.embedded) }.toNot(throwError())
                                }

                                it("should return the value from the backing value") {
                                    expect { try partial.value(for: \.embedded) }.to(equal(backingValue.embedded))
                                }
                            }

                            context("partialValue(for:)") {
                                it("should return a partial backed by the value from the backing value") {
                                    let result = partial.partialValue(for: \.embedded)
                                    expect(result.backingValue) == backingValue.embedded
                                }
                            }

                            context("the subscript") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial[\.embedded]
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }

                            context("dynamic member lookup") {
                                var result: Wrapped.Embedded?

                                beforeEach {
                                    result = partial.embedded
                                }

                                it("should return the value from the backing value") {
                                    expect(result) == backingValue.embedded
                                }
                            }
                        }
                        #endif
                    }
                }
            }
        }
    }
}