import SwiftUI

struct MeasurementListScreen: View {

    typealias ViewModel = MeasurementListViewModel

    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        stateView
            .navBar(title: viewModel.navTitle)
    }

}

private extension MeasurementListScreen {

    @ViewBuilder
    var stateView: some View {
        switch viewModel.state {
        case .items(let items):
            itemsView(items: items)
        case .idle:
            IdleView()
        }
    }

    func itemsView(items: [ViewModel.Item]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                    itemView(item: item)
                }
            }
        }
        .padding(20)
    }

    func itemView(item: ViewModel.Item) -> some View {
        Button(action: item.action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.title)
                            .fontStyle(size: .m, weight: .semibold, color: \.primary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(item.description)
                            .fontStyle(size: .m, weight: .regular, color: \.secondary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .disabled(!item.isEnabled)
        .opacity(item.isEnabled ? 1 : 0.5)
    }

}

