//
//  NetworkMonitor.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    @Published var isConnected: Bool = true

    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: "NetworkMonitorQueue")
        startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}

