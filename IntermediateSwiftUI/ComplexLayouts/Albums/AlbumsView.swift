//
//  GridsView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 11/11/2020.
//

import SwiftUI

struct AlbumsView: View {
    @State private var columns = Array(repeating: GridItem(.flexible(),
                                                    spacing: 0, alignment:
                                                        .center), count: 2)
    @State private var displayVertical = true

    var coverWidth: CGFloat {
        columns.count == 2 ? UIScreen.main.bounds.width / 2 - 32 : 64
    }


    var body: some View {
        VStack {
            HStack {
                Text("Albums View").font(.largeTitle).fontWeight(.bold)
                Spacer()
                Button {

                    withAnimation(Animation.easeIn(duration: 0.7)) {
                        if columns.count == 2 {
                            columns.removeLast()
                        } else {
                            columns.append(columns.first!)
                        }
                        displayVertical = columns.count == 2
                    }
                } label: {
                    Image(systemName: columns.count == 1 ? "square.split.2x1" : "square.split.1x2")
                        .imageScale(.large)

                }

            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(albums, id: \.album_name) { album in
                        AlbumGridView(displayVertical: displayVertical, identifier: album.album_name) {
                            Image(album.album_cover)
                                .resizable()
                                .frame(width: coverWidth, height: coverWidth)
                                .aspectRatio(1, contentMode: .fill)
                                .cornerRadius(16)
                                .tag(1)
                        } detail: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(album.album_name).fontWeight(.semibold)
                                Text(album.album_author).font(.caption).fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }.navigationTitle("Albums")
            .toolbar {

            }
        }

    }
}

struct AlbumGridView<Image: View, Detail: View>: View {

    var displayVertical: Bool
    var identifier: String
    var image: Image
    var detail: Detail
    let uuid = Int.random(in: 1...100)
    @Namespace private var animation

    init(displayVertical: Bool, identifier: String, @ViewBuilder image: () -> Image, @ViewBuilder detail: () -> Detail) {
        self.displayVertical = displayVertical
        self.image = image()
        self.detail = detail()
        self.identifier = identifier
    }

    var body: some View {
        if displayVertical {
            VStack {
                image
                    .matchedGeometryEffect(id: "image\(identifier)", in: animation)
                detail
                    .matchedGeometryEffect(id: "detail\(identifier)", in: animation)
            }
        } else {
            HStack {
                image
                    .matchedGeometryEffect(id: "image\(identifier)", in: animation)
                detail
                    .matchedGeometryEffect(id: "detail\(identifier)", in: animation)
                Spacer()
            }.padding(8)
        }

    }

    @ViewBuilder var contents: some View {
        image
        detail
    }
}

struct GridsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView()
    }
}
