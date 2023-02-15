//
//  SafeView.swift
//  Kasjer
//
//  Created by Woturios on 12/08/2022.
//

import SwiftUI

struct SafeView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 5) {
                Image(systemName: "xmark.app.fill")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 50))
                    .foregroundColor(.red)
                    .onTapGesture {
                        vm.reset()
                        self.presentationMode.wrappedValue.dismiss()
                    }


                VStack {
                    ZStack(alignment: .top) {
                        VStack {
                            HStack{
                                Text("Minimalna wartość kasetki:")
                                Spacer()
                                Text("\(vm.limit.asCurrencyWith2Decimals())")
                                    .fontWeight(.black)
                                    .font(.title2)
                            }
                            .padding()
                            .background(Color.blue)
                            .withSafeDataModifier()
                            
                            HStack{
                                Text("Cała gotówka:")
                                Spacer()
                                Text("\(vm.sum.asCurrencyWith2Decimals())")
                                    .fontWeight(.black)
                                    .font(.title2)
                            }
                            .padding()
                            .background(.green)
                            .withSafeDataModifier()
                            
                            HStack{
                                Text("Do kasetki:")
                                Spacer()
                                Text("\(vm.kasetka.asCurrencyWith2Decimals())")
                                    .fontWeight(.black)
                                    .font(.title2)
                            }
                            .padding()
                            .background(.pink)
                            .withSafeDataModifier()

                            HStack{
                                Text("Do sejfu schowaj:")
                                Spacer()
                                Text("\((vm.sum - vm.kasetka).asCurrencyWith2Decimals())")
                                    .fontWeight(.black)
                                    .font(.title2)
                            }
                            .padding()
                            .background(Color.cyan)
                            .withSafeDataModifier()
                        }
                        ScrollView(showsIndicators: false) {
                            VStack {
                                putToSafeList
                            }
                            .frame(minHeight: 300, alignment: .top)
                            .padding(.top)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.top, 350)
                        }
                        
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            vm.calculateSafe()
        }
    }
}

struct SafeView_Previews: PreviewProvider {
    static var previews: some View {
        SafeView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}


extension SafeView {
    
    private var putToSafeList: some View {
        ForEach(vm.safeInput) { item in
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 55)
                    
                    HStack(spacing: 0) {
                        Text(item.nominal.asCurrencyWith2Decimals())
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(height: 65)
                                .foregroundColor(Color.black)
                            
                            Text("\(item.count.asInteger())")
                                .font(.title)
                                .foregroundColor(Color.white)
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .foregroundColor(item.count < 0 ? Color.red.opacity(0.3) : Color.blue)
            .cornerRadius(10)
        }
    }
}
