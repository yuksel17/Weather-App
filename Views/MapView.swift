import SwiftUI
import MapKit

struct MapView: View {

    @Environment(\.dismiss) private var dismiss

    @StateObject private var locationManager = LocationManager()

    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 41.0082,
                longitude: 28.9784
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
        )
    )

    let onLocationSelected: (Double, Double) -> Void

    var body: some View {

        MapReader { proxy in

            Map(position: $position)
                .ignoresSafeArea()
                .onTapGesture { point in

                    if let coordinate = proxy.convert(point, from: .local) {

                        onLocationSelected(
                            coordinate.latitude,
                            coordinate.longitude
                        )

                        dismiss()
                    }
                }
                .onAppear {
                    locationManager.requestLocation()
                }
        }
    }
}

#Preview {
    MapView { _, _ in }
}
