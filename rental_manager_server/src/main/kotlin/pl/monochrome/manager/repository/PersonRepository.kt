package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.Person

interface PersonRepository: JpaRepository<Person, Int> {

    fun findByMail(mail: String): Person?

}