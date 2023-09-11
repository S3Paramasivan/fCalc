//
//  main.swift
//  fCalc
//
//  Created by SivA on 9/11/23.
//

import Foundation

func startCalculator() {
    if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
        if name == "exit" {
            exit(0)
        }
        else {
            let _ = name.evaluate()
        }
        startCalculator()
    }
}

startCalculator()


