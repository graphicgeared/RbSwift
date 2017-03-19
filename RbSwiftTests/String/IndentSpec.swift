//
//  IndentSpec.swift
//  RbSwift
//
//  Created by draveness on 19/03/2017.
//  Copyright © 2017 draveness. All rights reserved.
//

import Quick
import Nimble
import RbSwift

class StringIndentSpec: QuickSpec {
    override func spec() {
        describe(".indent(amount:str:)") {
            it("indents the lines in the reveiver") {
                expect("  foo".indent(2)).to(equal("\t\tfoo"))
                expect("  foo".indent(2, "  ")).to(equal("    foo"))
                expect("  foo\n\tbar".indent(2, "  ")).to(equal("    foo\n    bar"))
            }
        }
    }
}
