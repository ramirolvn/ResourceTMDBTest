import Foundation
import RealmSwift

class UserDao{
    
    class func saveUser(_ user : User) -> (Bool,String?){
        let realm = try! Realm()
        if realm.objects(User.self).count == 0{
            do {
                try realm.write {
                    realm.add(user)
                }
                return (true,nil)
            } catch let error{
                print("error saving settings ", error)
                return (false, "Erro ao salvar usuário!")
            }
        }else{
            return(false,"Usuário já cadastrado!")
        }
        
    }
    
    class func returnUser() -> User? {
        let realm = try! Realm()
        let users = realm.objects(User.self)
        if users.count > 0, let user = users.first{
            return user
        }
        return nil
    }
    
    class func deleteUser(_ id: String) -> (Bool,String?){
        let realm = try! Realm()
        if let user = realm.objects(User.self).filter("id = %@", "\(id)").first {
            
            do {
                try realm.write {
                    realm.delete(user, cascading: true)
                }
                return (true,nil)
            } catch let error{
                print("error deleting settings ", error)
                return (false, "Erro ao deletar usuário!")
            }
        }else{
            return (false, "Incosistência no banco!")
        }
        
    }
}



