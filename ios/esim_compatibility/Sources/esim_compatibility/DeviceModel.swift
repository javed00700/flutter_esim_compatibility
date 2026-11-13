import Foundation
import UIKit

public extension UIDevice {

    /// Checks whether the current iOS device (or simulated device) is eSIM compatible.
    func isEsimCompatible() -> Bool {
        let identifier = hardwareModelIdentifier

        // 1. Check against explicitly known eSIM-compatible model identifiers
        if Self.knownEsimIdentifiers.contains(identifier) {
            return true
        }

        // 2. Future-proof iPhone heuristic:
        // Every iPhone generation starting from iPhone XR/XS (iPhone11,x) supports eSIM.
        // If the model starts with "iPhone" and has a major version >= 11, it is eSIM-compatible.
        if identifier.hasPrefix("iPhone") {
            let versionPart = identifier.dropFirst("iPhone".count)
            if let commaIndex = versionPart.firstIndex(of: ",") {
                let majorStr = versionPart[..<commaIndex]
                if let major = Int(majorStr), major >= 11 {
                    return true
                }
            }
        }

        return false
    }

    /// Retrieves the hardware model identifier (e.g. "iPhone15,2" or "iPhone16,1").
    /// If running in a simulator, returns the simulated device identifier from the environment.
    var hardwareModelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let rawIdentifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        // Check for iOS Simulator
        if rawIdentifier == "i386" || rawIdentifier == "x86_64" || rawIdentifier == "arm64" {
            if let simModel = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"],
               !simModel.isEmpty {
                return simModel
            }
        }

        return rawIdentifier
    }

    /// Static set of all known Apple devices with eSIM hardware support.
    private static let knownEsimIdentifiers: Set<String> = [
        // MARK: - iPhone Models
        // iPhone XR, XS, XS Max
        "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8",
        // iPhone 11, 11 Pro, 11 Pro Max
        "iPhone12,1", "iPhone12,3", "iPhone12,5",
        // iPhone SE (2nd generation)
        "iPhone12,8",
        // iPhone 12 Mini, 12, 12 Pro, 12 Pro Max
        "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4",
        // iPhone 13 Mini, 13, 13 Pro, 13 Pro Max
        "iPhone14,4", "iPhone14,5", "iPhone14,2", "iPhone14,3",
        // iPhone SE (3rd generation)
        "iPhone14,6",
        // iPhone 14, 14 Plus, 14 Pro, 14 Pro Max
        "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3",
        // iPhone 15, 15 Plus, 15 Pro, 15 Pro Max
        "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2",
        // iPhone 16, 16 Plus, 16 Pro, 16 Pro Max, 16e
        "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone17,5",
        // iPhone 17 series & future anticipated models
        "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4", "iPhone18,5",
        "iPhone19,2", "iPhone19,3", "iPhone19,4", "iPhone19,7",

        // MARK: - iPad Models (Cellular + eSIM)
        // iPad (7th, 8th, 9th, 10th gen, A16)
        "iPad7,12", "iPad11,7", "iPad12,2", "iPad13,19", "iPad15,8",
        // iPad Air (3rd, 4th, 5th gen, M2, M3, M4)
        "iPad11,4", "iPad13,2", "iPad13,17", "iPad14,9", "iPad14,11",
        "iPad15,4", "iPad15,6", "iPad16,9", "iPad16,11",
        // iPad mini (5th, 6th gen, A17 Pro)
        "iPad11,2", "iPad14,2", "iPad16,2",
        // iPad Pro 11-inch (1st, 2nd, 3rd, 4th gen, M4, M5)
        "iPad8,2", "iPad8,4", "iPad8,10", "iPad13,5", "iPad13,7",
        "iPad14,4", "iPad16,4", "iPad17,2",
        // iPad Pro 12.9-inch (3rd, 4th, 5th, 6th gen) & 13-inch (M4, M5)
        "iPad8,6", "iPad8,8", "iPad8,12", "iPad13,9", "iPad13,11",
        "iPad14,6", "iPad16,6", "iPad17,4"
    ]
}
