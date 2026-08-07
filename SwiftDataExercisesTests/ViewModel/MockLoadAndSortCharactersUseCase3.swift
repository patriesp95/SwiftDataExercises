//
//  MockLoadAndSortCharactersUseCase3.swift
//  SwiftDataExercisesTests
//
//  Created by Patricia M Espert on 04/08/2026.
//


import Foundation
@testable import SwiftDataExercises

@MainActor
final class MockLoadAndSortCharactersUseCase3: LoadAndSortCharactersUseCase3Protocol {

    private(set) var callCount = 0
    private(set) var receivedPages: [Int] = []
    var results: [Result<CharacterPage3, Error>]

    private var isGated = false
    private var hasStarted = false
    private var gate: CheckedContinuation<Void, Never>?
    private var startWaiters: [CheckedContinuation<Void, Never>] = []

    init(results: [Result<CharacterPage3, Error>]) {
        self.results = results
    }

    convenience init(result: Result<CharacterPage3, Error>) {
        self.init(results: [result])
    }

    func execute(page: Int) async throws -> CharacterPage3 {
        receivedPages.append(page)
        callCount += 1
        let currentResult = results[min(callCount - 1, results.count - 1)]

        if isGated {
            hasStarted = true
            let waiters = startWaiters
            startWaiters.removeAll()
            for waiter in waiters { waiter.resume() }
            await withCheckedContinuation { self.gate = $0 }
        }

        return try currentResult.get()
    }

    /// Hace que la próxima llamada a `execute` se quede suspendida hasta llamar a `resume()`.
    func suspendNextCall() {
        isGated = true
        hasStarted = false
    }

    /// Espera hasta que la llamada gated haya entrado en `execute` y esté suspendida.
    func waitForCallStart() async {
        if hasStarted { return }
        await withCheckedContinuation { startWaiters.append($0) }
    }

    /// Libera la llamada suspendida.
    func resume() {
        isGated = false
        gate?.resume()
        gate = nil
    }
}
