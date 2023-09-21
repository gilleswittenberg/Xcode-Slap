//
//  Clock.swift
//  Slap
//
//  Created by Gilles Wittenberg on 27/08/2023.
//

import Foundation

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

fileprivate func averageDuration (_ durations: [Duration]) -> Duration {
    let sum = durations.reduce(.seconds(0), +)
    return sum / durations.count
}

fileprivate func calculateBPM (_ taps: [SuspendingClock.Instant]) -> Double? {
    let lastTaps = Array(taps.suffix(6))
    let durations = filterDurations(diffClockInstants(lastTaps))
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
    private var timer: Timer?
    
    func appendTap () {
        taps.append(clock.now)
        BPM = calculateBPM(taps)
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
