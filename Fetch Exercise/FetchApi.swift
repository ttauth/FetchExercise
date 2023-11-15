import Foundation

// This class fetches data from TheMealDB API.
class FetchApi {
    // The base URL for TheMealDB API.
    private let baseURL = "https://themealdb.com/api/json/v1/1"
    // Fetches a list of desserts from the API.
    func fetchDesserts(completion: @escaping (MealList?) -> Void) {

        let urlString = "\(baseURL)/filter.php?c=Dessert"
    
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        // Create and start a data task to fetch the desserts.
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            // Decode the data into a MealList object.
            do {
                let decodedData = try JSONDecoder().decode(MealList.self, from: data)
                // If decoding is successful, pass the data back via completion handler.
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                // If decoding fails, print an error and complete with nil.
                print("JSON Decoding Error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }

    // Fetches details for a specific meal by its ID.
    func fetchMealDetail(mealID: String, completion: @escaping (Meal?) -> Void) {
        let urlString = "\(baseURL)/lookup.php?i=\(mealID)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }

        // Create and start a data task to fetch the meal details.
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // Attempt to decode the data into a MealDetail object.
            do {
                let decodedData = try JSONDecoder().decode(MealDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData.meals.first)
                }
            } catch {
                print("JSON Decoding Error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
