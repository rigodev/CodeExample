import Combine

final class MeasurementListViewModel: ObservableObject {

    @Published private(set) var state: State = .idle

    let navTitle = String(localized: "Measurements.navTitle")

    private let onShtange: () -> Void
    private let onGenche: () -> Void

    init(onShtange: @escaping () -> Void, onGenche: @escaping () -> Void) {
        self.onShtange = onShtange
        self.onGenche = onGenche
        self.state = itemsState()
    }

}

private extension MeasurementListViewModel {

    func itemsState() -> State {
        let shtangeItem = Item(
            image: "shtange_measurement",
            title: String(localized: "Measurements.shtange.title"),
            description: String(localized: "Measurements.shtange.description"),
            isEnabled: true,
            action: { [weak self] in
                self?.onShtange()
            }
        )

        let gencheItem = Item(
            image: "genche_measurement",
            title: String(localized: "Measurements.genche.title"),
            description: String(localized: "Measurements.genche.description"),
            isEnabled: false,
            action: { [weak self] in
                self?.onGenche()
            }
        )

        return .items([shtangeItem, gencheItem])
    }

}

extension MeasurementListViewModel {

    enum State {
        case idle
        case items([Item])
    }

    struct Item {
        let image: String
        let title: String
        let description: String
        let isEnabled: Bool
        let action: () -> Void
    }

}
