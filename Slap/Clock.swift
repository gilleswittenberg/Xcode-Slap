//
//  Clock.swift
//  Slap
//
//  Created by Gilles Wittenberg on 27/08/2023.
//

import Foundation

fileprivate enum AverageAlgorithm {
    case instant, average, weighted
}

fileprivate func averageDuration (_ durations: [Duration]) -> Duration {
    let sum = durations.reduce(.seconds(0), +)
    return sum / durations.count
}

fileprivate func averageWeightedDuration (_ durations: [Duration]) -> Duration {
    let sum = durations.enumerated().reduce(Duration.seconds(0), { (accumulate, current) in
        let index = current.0
        let value = current.1
        let multiplier: Double = 1 + Double(index) * 0.2
        return accumulate + value * multiplier
    })
    let denominator = durations.enumerated().reduce(0, { (accumulate, current) in
        let index = current.0
        let multiplier = 1 + Double(index) * 0.2
        return accumulate + multiplier
    })
    return sum / denominator
}

fileprivate func calculateAverageDuration (_ durations: [Duration], _ algorithm: AverageAlgorithm) -> Duration {
    switch algorithm {
    case .instant:
        return averageDuration(durations)
    case .average:
        return averageDuration(durations)
    case .weighted:
        return averageWeightedDuration(durations)
    }
}

fileprivate func diffClockInstants (_ taps: [SuspendingClock.Instant]) -> [Duration] {
    var diffs: [Duration] = []
    for (index, tap) in taps.enumerated() {
        let nextIndex = index + 1
        guard taps.indices.contains(nextIndex) else { continue }
        let nextTap = taps[nextIndex]
        diffs.append(nextTap - tap)
    }
    return diffs
}

fileprivate func filterDurations (_ durations: [Duration]) -> [Duration] {
    durations.filter { d in d > .seconds(0) }
}

fileprivate func lastTaps (_ taps: [SuspendingClock.Instant], _ algorithm: AverageAlgorithm) -> [SuspendingClock.Instant] {
    switch algorithm {
    case .instant:
        return Array(taps.suffix(2))
    case .average:
        return taps
    case .weighted:
        return Array(taps.suffix(6))
    }
}

fileprivate func calculateBPM (_ allTaps: [SuspendingClock.Instant], algorithm: AverageAlgorithm = .instant) -> Double? {
    let taps = lastTaps(allTaps, algorithm)
    let durations = filterDurations(diffClockInstants(taps))
    guard durations.isEmpty == false else { return nil }
    let d = averageDuration(durations)
    guard d > .seconds(0) else { return nil }
    return .seconds(60) / d
}

class Clock: ObservableObject {
    
    @Published var BPM: Double?
    var numTaps: Int { taps.count }
    
    private var _clock: SuspendingClock?
    private var clock: SuspendingClock {
        if _clock == nil {
            _clock = SuspendingClock()
        }
        return _clock!
    }
    
    private var taps: [SuspendingClock.Instant] = []
    private var algorithm = AverageAlgorithm.weighted
    private var timer: Timer?
    
    func appendTap () {
        taps.append(clock.now)
        BPM = calculateBPM(taps, algorithm: algorithm)
        scheduleTimer()
    }
    
    func clear (_ clearBPM: Bool = true) {
        _clock = nil
        taps = []
        if clearBPM {
            BPM = nil
        }
    }
    
    private func scheduleTimer () {
        if let timer = timer {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 3.1, repeats: false) { timer in
            self.clear(false)
        }
    }
}
