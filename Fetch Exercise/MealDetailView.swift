import SwiftUI

struct MealDetailView: View {
    @State private var meal: Meal?  // The meal detail state, initially nil until data is loaded.
    let mealID: String  // The ID of the meal to load details for.

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) { // Align text to the leading edge
                if let meal = meal {
                    Text(meal.strMeal)
                        .font(.largeTitle)
                        .padding(.bottom) // Add some space after the title

                    Text("Ingredients and Measurements:")
                        .font(.headline)
                        .padding(.vertical, 2) // Add some space before the list

                    ForEach(meal.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .padding(.vertical, 2)
                    }
                    
                    Text("Instructions:")
                        .font(.headline)
                        .padding(.vertical, 2) // Add some space before the instructions
                    
                    // Split the instructions into steps and number them.
                    let instructionSteps = meal.strInstructions.split(whereSeparator: \.isNewline)
                    ForEach(0..<instructionSteps.count, id: \.self) { index in
                        let step = instructionSteps[index]
                        Text("\(index + 1). \(step.trimmingCharacters(in: .whitespaces))")
                            .padding(.bottom, 2) // Add some space after each step
                    }
                } else {
                    Text("Loading...")
                }
            }
        }
        .padding()
        .onAppear(perform: loadData)
    }

    func loadData() {
        FetchApi().fetchMealDetail(mealID: mealID) { mealDetail in
            // Update the state with the fetched meal details.
            meal = mealDetail
        }
    }
}
