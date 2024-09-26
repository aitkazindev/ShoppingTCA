//
//  ContentView.swift
//  ShoppingTCA
//var body: some View {
//  Created by Ibrahim Aitkazin on 25.09.2024.
//

import SwiftUI
import ComposableArchitecture


struct CounterDomain: Reducer {
    struct State: Equatable {
        var counter = 0
    }

    enum Action: Equatable {
        case increaseCounter
        case decreaseCounter
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action{
            case .increaseCounter:
                state.counter += 1
                return .none
            case .decreaseCounter:
                state.counter -= 1
                return .none
            }
        }
    }
}



struct ContentView: View {
    let store: StoreOf<CounterDomain>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Button {
                    viewStore.send(.decreaseCounter)
                } label: {
                    Text("-")
                        .padding(10)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)

                Text(viewStore.counter.description)
                    .padding(5)

                Button {
                    viewStore.send(.increaseCounter)
                } label: {
                    Text("+")
                        .padding(10)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
#Preview {
    ContentView(store: .init(initialState: CounterDomain.State(), reducer: {
        CounterDomain()
    }))
}
