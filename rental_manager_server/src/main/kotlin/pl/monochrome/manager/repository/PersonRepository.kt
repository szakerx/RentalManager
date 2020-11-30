package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.Person
import java.util.*

interface PersonRepository: JpaRepository<Person, UUID>