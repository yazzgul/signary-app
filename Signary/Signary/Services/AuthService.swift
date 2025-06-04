
import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {

    public static let shared = AuthService()

    private init() {}

    private let dataBase = Firestore.firestore()

    private var usersReference: CollectionReference {
        return dataBase.collection("users")
    }

    public func updateUserInfoInFirebase(with userInSignary: UserInSignary, completion: @escaping (Bool, Error?) -> Void) {
        usersReference
            .document(userInSignary.userUID)
            .setData([
                "username": userInSignary.username,
                "email": userInSignary.email,
                "learntWords": userInSignary.learntWords
            ]) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            }

    }

    public func signUp(with userRequest: UserRegisterRequest, completion: @escaping (Bool, Error?) -> Void) {

        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let resultUser = result?.user else {
                completion(false, error)
                return
            }

            let newUser = UserInSignary(username: username, email: email, userUID: resultUser.uid, learntWords: [])

            self?.updateUserInfoInFirebase(with: newUser) { _, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                completion(true, nil)

            }

//            self.usersReference
//                .document(resultUser.uid)
//                .setData([
//                    "username": username,
//                    "email": email
//                ]) { error in
//                    if let error = error {
//                        completion(false, error)
//                        return
//                    }
//                    completion(true, nil)
//
//                }
        }

    }

    public func signIn(with userRequest: UserLoginRequest, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            } else {
                completion(true, nil)
            }
        }
    }

    public func checkAuthenticationIsCurrentUserExist() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
            return true
        }
    }

    public func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let error {
            completion(false, error)
        }
    }

    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

    public func fetchUser(completion: @escaping (UserInSignary?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }

        usersReference
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }

                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshotData["username"] as? String,
                   let email = snapshotData["email"] as? String,
                   let learntWords = snapshotData["learntWords"] as? [String] {
                    let user = UserInSignary(username: username, email: email, userUID: userUID, learntWords: learntWords)
                    completion(user, nil)
                }
            }
    }
    func deleteUser(completion: @escaping (Error?) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("Error in getting uid of current user")
            return
        }
        usersReference.document(currentUserUID).delete { error in
            completion(error)
        }
    }
}
