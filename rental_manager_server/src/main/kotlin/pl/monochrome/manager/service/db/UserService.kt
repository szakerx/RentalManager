package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.User
import pl.monochrome.manager.repository.UserRepository
import java.util.*

@Service
class UserService @Autowired constructor(private val repository: UserRepository) {

    fun getAllUsers(): List<User> = repository.findAll()

    fun deleteAllUsers() = repository.deleteAll()

    fun add(user: User) = repository.save(user)

    fun getUserById(userId: String) = repository.findById(userId).get()
}