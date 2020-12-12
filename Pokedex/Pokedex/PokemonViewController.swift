import UIKit

var savedData = UserDefaults.standard

class PokemonViewController: UIViewController {
    var url: String!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var catchButton: UIButton!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var descriptionText: UITextView!
    
    var myPokemons: [String : Bool] = [:]
    var pokemonSpecies: PokemonSpecies!

    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nameLabel.text = ""
        numberLabel.text = ""
        type1Label.text = ""
        type2Label.text = ""

        loadPokemon()
      
    }
    
    func loadDescription(pokemonID: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemonID)/") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PokemonSpecies.self, from: data)
                self.pokemonSpecies = result
                let flavor_text: FlavorTextEntry = self.pokemonSpecies.flavor_text_entries[0]
                DispatchQueue.main.async {
                    self.descriptionText.text = flavor_text.flavor_text
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }

    func loadPokemon() {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonResult.self, from: data)
                DispatchQueue.main.async {
                    
                    self.loadDescription(pokemonID: result.id)
                    
                    self.navigationItem.title = self.capitalize(text: result.name)
                    self.nameLabel.text = self.capitalize(text: result.name)
                    self.numberLabel.text = String(format: "#%03d", result.id)
                    
                    let spriteUrl = URL(string: result.sprites.front_default)
                    let spriteData = try! Data(contentsOf: spriteUrl!)
                    self.pokemonImage.image = UIImage(data: spriteData)
                    
                    if savedData.bool(forKey: self.nameLabel.text!) == true {
                        self.myPokemons[self.nameLabel.text!] = true
                        self.catchButton.backgroundColor = UIColor(ciColor: .green)
                        self.catchButton.setTitle("Release", for: .normal)
                    } else {
                        savedData.set(false, forKey: self.nameLabel.text!)
                        self.myPokemons[self.nameLabel.text!] = false
                    }

                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                    
                }
                
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    @IBAction func toggleCatch() {
        if myPokemons[self.nameLabel.text!] == true {
            self.catchButton.backgroundColor = UIColor(ciColor: .red)
            self.catchButton.setTitle("Catch", for: .normal)
            savedData.set(false, forKey: self.nameLabel.text!)
            myPokemons[self.nameLabel.text!] = false
            return
        }
        self.catchButton.backgroundColor = UIColor(ciColor: .green)
        self.catchButton.setTitle("Release", for: .normal)
        savedData.set(true, forKey: self.nameLabel.text!)
        myPokemons[self.nameLabel.text!] = true
        return

    }

}
//// Code from stackoverflow to round the corners of my button
//@IBDesignable class MyButton: UIButton
//{
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        updateCornerRadius()
//    }
//
//    @IBInspectable var rounded: Bool = false {
//        didSet {
//            updateCornerRadius()
//        }
//    }
//
//    func updateCornerRadius() {
//        layer.cornerRadius = rounded ? frame.size.height / 5 : 0
//    }
//}
