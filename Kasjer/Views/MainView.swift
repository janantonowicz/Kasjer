//
//  MainView.swift
//  Kasjer
//
//  Created by Woturios on 10/08/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State var isPresented: Bool = false
    @State var calculatorTapped: Int = 0
    @State var deleteID: UUID = UUID()
    @State var fullscreenCover: Bool = false
    
    @State var pomCounter = 0.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                suma
                    .opacity(vm.sum >= vm.limit ? 1 : 0)
                    .animation(.easeInOut, value: vm.sum >= vm.limit)
                nominals
                calculator
            }
            .zIndex(999)
            
            VStack(alignment: .leading) {
                navigation
                HStack {
                    Button {
                        guard vm.selectedNominal != 0.0 else { return }
                        vm.array.append(ItemModel(
                            nominal: vm.selectedNominal,
                            count: pomCounter,
                            id: UUID(),
                            theValue: pomCounter*vm.selectedNominal))
                        vm.sumItems()
                        pomCounter = 0.0
                        vm.selectedNominal = vm.values[vm.indexOfValue+1]
                        vm.indexOfValue += 1
                    } label: {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                            .font(.largeTitle)
                    }
                    .opacity(pomCounter > 0 ? 1 : 0)

                    calculations
                }
                list
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}

extension MainView {
    private var suma: some View {
        ZStack {
            Color.orange
                .frame(width: 140, height: 60)
                .cornerRadius(50)
            
            HStack {
                Text("Sum")
                    .font(.title)
                    .foregroundColor(Color.orange)
                    .fontWeight(.bold)
                Image(systemName: "arrow.forward")
                    .font(.title)
                    .foregroundColor(Color.orange)
            }
            .frame(width: 135, height: 55)
            .background(Color.black)
            .cornerRadius(50)
        }
        .onTapGesture {
            fullscreenCover.toggle()
        }
        .fullScreenCover(isPresented: $fullscreenCover, content: {
            SafeView()
        })
        .frame(maxWidth:.infinity, alignment: .trailing)
        .padding(.bottom, 8)
        
    }
    
    private var nominals: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.values, id: \.self) { value in
                    Text(value.asCurrencyWith2Decimals())
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(width: 120, height: 80)
                        .background(vm.selectedNominal == value ? Color.blue : Color.white.opacity(0.2))
                        .cornerRadius(5)
                        .onTapGesture {
                            if vm.selectedNominal != value {
                                pomCounter = 0.0
                            }
                            vm.selectedNominal = value
                            vm.plusMinus = false
                            if let index = vm.values.firstIndex(where: { $0 == value }){
                                vm.indexOfValue = index
                            }
                            print("\(vm.selectedNominal)")
                            print("\(pomCounter)")
                        }
                }
            }
        }
    }
    
    private var calculator: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(vm.plusMinus ? Color.red : Color.orange)
                
                Image(systemName: vm.plusMinus ? "minus" : "plus")
                    .font(.largeTitle)
            }
            .onTapGesture {
                vm.plusMinus.toggle()
            }
            .animation(.easeOut, value: vm.plusMinus)
            
            ForEach(vm.change, id: \.self) { change in
                ZStack {
                    Circle()
                        .foregroundColor(calculatorTapped == change ?  Color.red : Color.gray)
                    
                    Text("\(change)")
                        .font(.largeTitle)
                }
                .frame(maxWidth: 100)
                .onTapGesture {
                    if vm.plusMinus == false {
                        pomCounter = pomCounter + Double(change)
                    } else {
                        pomCounter = pomCounter - Double(change)
                        guard pomCounter > 0 else { return pomCounter = 0 }
                        vm.plusMinus = false
                    }
                }
            }
        }
        .frame(height: 80)
        .zIndex(2)
        .foregroundColor(Color.white)
        .padding(5)
    }
}

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}

extension MainView {
    private var navigation: some View {
        HStack {
            Image(systemName: "xmark.bin.fill")
                .font(.title)
                .foregroundColor(Color.red)
                .onTapGesture {
                    vm.reset()
                    pomCounter = 0.0
                }
            Spacer()
            ballance
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.title)
                .foregroundColor(Color.blue)
                .onTapGesture {
                    isPresented.toggle()
                }
                .sheet(isPresented: $isPresented) {
                    SettingsView()
                }
        }
    }
    
    private var ballance: some View {
        Text(vm.sum == 0 ? "No money" : vm.sum.asCurrencyWith2Decimals())
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .center)
            .animation(.easeInOut, value: vm.sum == 0)
    }
    
    private var calculations: some View {
        HStack {
            Spacer()
            Text("\(pomCounter.asInteger())")
                .fontWeight(.semibold)
            Image(systemName: "xmark")
            Text("\(vm.selectedNominal.asCurrencyWith2Decimals())")
                .fontWeight(.semibold)
        }
            .font(.system(size: 50))
            .frame(maxWidth: .infinity, minHeight: 70 , alignment: .bottomTrailing)
            .frame(height: 70)
            .animation(.easeInOut, value: vm.sum == 0)
    }
    
    private var list: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(vm.array.reversed()) { item in
                    ZStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(height: 55)
                            
                            HStack(spacing: 0) {
                                Text(item.nominal.asCurrencyWith2Decimals())
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("\(item.theValue.asCurrencyWith2Decimals())")
                                    .font(.headline)
                            }
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                        }
                        
                        ZStack {
                            Circle()
                                .frame(height: 65)
                                .foregroundColor(Color.black)
                            
                            Text("\(item.count.asInteger())")
                                .font(.title)
                                .foregroundColor(Color.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .foregroundColor(item.count < 0 ? Color.red.opacity(0.3) : Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            Rectangle()
                .frame(height: 70)
                .opacity(0.0001)
        }
        .frame(maxHeight: UIScreen.main.bounds.height - 400)
    }
}
