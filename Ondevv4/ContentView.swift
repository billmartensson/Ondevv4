//
//  ContentView.swift
//  Ondevv4
//
//  Created by BillU on 2024-11-06.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State var inBeds = ""
    @State var inBaths = ""
    @State var inSqft = ""

    @State var predictedPrice: Int?
    
    @State var errorMessage = ""
    
    var body: some View {
        VStack {
            
            if errorMessage != "" {
                Text(errorMessage)
                    .font(.title)
                    .foregroundColor(Color.red)
            }
            
            if predictedPrice != nil {
                Text("\(predictedPrice!)")
                    .font(.title)
                    .foregroundColor(Color.green)

            }
            
            Text("Predict price")
                
            
            TextField("Beds", text: $inBeds)
            TextField("Baths", text: $inBaths)
            TextField("Sqft", text: $inSqft)
            
            Button("Predict") {
                predictprice()
            }
        }
        .padding()
        .onAppear() {
            
        }
    }
    
    func predictprice() {
        
        errorMessage = ""
        
        guard let bath = Int64(inBaths), let bed = Int64(inBeds), let sqft = Int64(inSqft) else {
            
            errorMessage = "Please enter valid values"
        return }
         
        do {
            let pricemodel = try NYrealestateModel(configuration: .init())
            
            let priceinput = NYrealestateModelInput(beds: bed, baths: bath, sqft: sqft)
            
            let priceoutput = try pricemodel.prediction(input: priceinput)
            
            predictedPrice = Int(priceoutput.tx_price)
            
        } catch {
            
        }
        
    }
}

#Preview {
    ContentView()
}
