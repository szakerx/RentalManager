package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.User

interface UserRepository: JpaRepository<User, String>