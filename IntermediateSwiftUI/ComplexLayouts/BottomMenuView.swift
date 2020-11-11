//
//  CustomView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 10/11/2020.
//

import SwiftUI

struct BottomMenuView: View {
	@State private var bottomSheetIsShown = false
	@State var selectedNumber: Int?
	
	var body: some View {
		
		
		ZStack() {
			VStack {
				Text("Bottom floating Menu").font(.title).bold().padding(.vertical)
				Spacer()
				Button {
					withAnimation {
						bottomSheetIsShown.toggle()
					}
				} label: {
					if let number = selectedNumber {
						Text("Selected number \(number)")
					} else {
						Text("Select a number :-D")
					}
				}
				Spacer()
				
			}
			
			BottomSheet(bottomSheetIsShown: $bottomSheetIsShown) {
				selectedNumber = $0
			}
			
		}
	}
}

private struct BottomSheet: View {
	@Binding var bottomSheetIsShown: Bool
	var selectedNumber: (Int) -> Void
	@State var yOffset: CGFloat = 0
	var body: some View {
		VStack {
			Spacer()
			VStack {
				Capsule().fill(Color.gray).frame(width: 100, height: 4)
					.padding(.vertical)
				ScrollView(.vertical, showsIndicators: true) {
					VStack {
						ForEach((1...10), id: \.self) { i in
							HStack {
								Spacer()
								Text("Line \(i)").bold()
									.padding(.vertical)
								Spacer()
							}
							.onTapGesture {
								withAnimation {
									selectedNumber(i)
									bottomSheetIsShown.toggle()
								}
							}
						}
					}
				}
				.frame(height: UIScreen.main.bounds.height / 3)
			}
			.background(BlurView().clipShape(MyCustomShape()))
			.offset(y: yOffset)
			.gesture(DragGesture().onChanged(onChangedDrag).onEnded(onEnded))
			.offset(x: 0, y: bottomSheetIsShown ? 0 : UIScreen.main.bounds.height)
			.edgesIgnoringSafeArea(.top)
		}
		.background(Color.black.opacity(bottomSheetIsShown ? 0.3 : 0))
		.edgesIgnoringSafeArea(.top)
		
		
	}
	
	private func onChangedDrag(value: DragGesture.Value) {
		if value.translation.height > 0 {
			yOffset = value.translation.height
		}
	}
	
	private func onEnded(value: DragGesture.Value) {
		if value.translation.height > 0 {
			withAnimation(Animation.easeIn(duration: 0.5)) {
				if value.translation.height > UIScreen.main.bounds.height / 8 {
					bottomSheetIsShown.toggle()
				}
				yOffset = 0
			}
		}
	}
}


struct CustomView_Previews: PreviewProvider {
	static var previews: some View {
		BottomMenuView()
	}
}

struct MyCustomShape: Shape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: CGPoint(x: 0, y: 50))
			path.addQuadCurve(to: CGPoint(x: 50, y: 0), control: CGPoint(x: 0, y: 0))
			path.addLine(to: CGPoint(x: rect.width - 50, y: 0))
			path.addQuadCurve(to: CGPoint(x: rect.width, y: 50), control: CGPoint(x: rect.width, y: 0))
			path.addLine(to: CGPoint(x: rect.width, y: rect.height))
			path.addLine(to: CGPoint(x: 0, y: rect.height))
			path.addLine(to: CGPoint(x: 0, y: 50))
		}
	}
}

struct BlurView: UIViewRepresentable {
	func makeUIView(context: Context) -> UIVisualEffectView {
		UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
	}
	
	func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
		
	}
}
