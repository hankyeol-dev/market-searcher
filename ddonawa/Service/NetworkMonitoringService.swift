//
//  NetworkMonitoringService.swift
//  ddonawa
//
//  Created by 강한결 on 10/27/24.
//
import Network

final class NetworkMonitorService {
   static let manager: NetworkMonitorService = .init()
   private init() {}

   private let queue = DispatchQueue(label: "network_monitor")
   private let monitor = NWPathMonitor()
   private(set) var isConnected: Bool = false
   
   func startMonitoring(completionHandler: @escaping (Bool) -> Void) {
      monitor.start(queue: queue)
      monitor.pathUpdateHandler = { [weak self] path in
         guard let self else { return }
         isConnected = path.status == .satisfied
         
         DispatchQueue.main.async {
            completionHandler(self.isConnected)
         }
      }
   }
   
   func stopMonitoring() {
      monitor.cancel()
   }
}
