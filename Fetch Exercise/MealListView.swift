import SwiftUI

struct MealListView: View {
    @State private var meals: [MealPreview] = []
    func loadData() {
        FetchApi().fetchDesserts { mealList in
            if let mealList = mealList {
                meals = mealList.meals.sorted()
            }
        }
    }
    var body: some View {
            NavigationView {
                List(meals) { meal in
                    NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                        HStack(spacing: 15) {
                            
                            Text(meal.strMeal.capitalized)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.primary)
                            
                            Spacer() // Pushes the text and icon to the edges.
                        }
                        .padding(.vertical, 8) // Adds more tap area.
                    }
                }
                .onAppear(perform: loadData)
                .navigationTitle("Desserts")
                .listStyle(PlainListStyle()) // plain list style for a cleaner look.
            }
        }


}


